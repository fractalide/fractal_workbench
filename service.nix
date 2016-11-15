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
  serviceSubnet = support.buildFractalideSubnet rec {
    src = ./.;
    name = "workbench_service";
    subnet = ''
    '${contracts.net_http_contracts.address}:(address="${cfg.bindAddress}:${toString cfg.port}")' -> listen workbench(${fractal.components.workbench})
    '${contracts.path}:(path="${cfg.dbPath}/${cfg.dbName}")' -> db_path workbench()
    '';
  };
  fvm = import (<fractalide> + "/support/fvm/") {inherit pkgs support contracts components;};
in
{
  options.services.workbench = {
    enable = mkEnableOption "Fractalide Workbench Example";
    package = mkOption {
      default = serviceSubnet;
      defaultText = "fractalComponents.workbench";
      type = types.package;
      description = ''
        Workbench example.
      '';
    };
    user = mkOption {
      type = types.str;
      default = "workbench";
      description = "User account under which workbench runs.";
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
      default = 8080;
      description = ''
        Defined the port number to listen.
      '';
    };
    dbName = mkOption {
      type = types.str;
      default = "todos.db";
      description = "the database file name.";
    };
    dbPath = mkOption {
      type = types.path;
      default = "/var/fractalide/workbench";
      description = "The DB will be written to this directory, with the filename specified using the 'dbName' configuration.";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to open ports in the firewall for the server.
      '';
    };
  };
  config = mkIf cfg.enable {
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
    users.extraUsers.workbench = {
      name = cfg.user;
      #uid = config.ids.uids.workbench;
      description = "Workbench database user";
    };
    systemd.services.workbench_init = {
      description = "Workbench Server Initialisation";
      wantedBy = [ "workbench.service" ];
      before = [ "workbench.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        install -d -m0700 -o ${cfg.user} ${cfg.dbPath}
        chown -R ${cfg.user} ${cfg.dbPath}
      '';
    };
    systemd.services.workbench = {
      description = "Workbench example";
      path = [ cfg.package ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        PermissionsStartOnly = true;
        Restart = "always";
        ExecStart = "${fvm}/bin/fvm ${cfg.package}";
        User = cfg.user;
      };
    };
    environment.systemPackages = [ fvm cfg.package ];
  };
}
