{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.workbench;
  fractalide = import <fractalide> {};
  support = fractalide.support;
  contracts = fractalide.contracts;
  components = fractalide.components;
  fractal = import ./default.nix { inherit pkgs support contracts components;
    fractalide = null;
  };
  serviceLevelSubnet = support.buildFractalideSubnet rec {
    src = ./.;
    name = "workbench_service";
    subnet = ''
    '${contracts.net_http_contracts.address}:(address="${cfg.bindAddress}:${toString cfg.port}")' ->
    listen workbench(${fractal.components.workbench})
    '';
  };
  vm = import (<fractalide> + "/support/vm/") {
    inherit pkgs support contracts components;
    exeSubnet = serviceLevelSubnet;
  };
in
{
  options.services.workbench = {
    enable = mkEnableOption "Fractalide Workbench Example";

    package = mkOption {
      default = vm;
      defaultText = "fractalComponents.workbench";
      type = types.package;
      description = ''
        Workbench example.
      '';
    };
    bindAddress = mkOption {
      type = types.string;
      default = "127.0.0.1";
      description = ''
        Defines the IP address by which workbench will be accessible.
      '';
    };
    port = mkOption {
      type = types.int;
      default = 5984;
      description = ''
        Defined the port number to listen.
      '';
    };
  };
  config = mkIf cfg.enable {
    systemd.services.workbench = {
      description = "Workbench example";
      path = [ cfg.package ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        PermissionsStartOnly = true;
        Restart = "always";
        ExecStart = "${cfg.package}/bin/workbench";
      };
    };
    environment.systemPackages = [ cfg.package ];
  };
}
