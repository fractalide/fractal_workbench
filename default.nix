{
  fractalide ? import <fractalide> {}
  , pkgs ? fractalide.pkgs
  , support ? fractalide.support
  , contracts ? fractalide.contracts
  , components ? fractalide.components
}:
with pkgs.lib;
let
  cfg = pkgs.config.services.fratalide_workbench;
  fractalContracts = import ./contracts {inherit pkgs support allContracts;};
  fractalComponents = import ./components {inherit pkgs support allContracts allComponents;};
  allContracts = contracts // fractalContracts;
  allComponents = components // fractalComponents;
  ## export components and contracts, allowing the composition of subnets
  publicNamespace = { components = fractalComponents; contracts = fractalContracts; };
  ### service - allowing the composition of services.
  serviceSubnet = support.buildFractalideSubnet rec {
    src = ./.;
    name = "workbench_service";
    subnet = ''
      '${allContracts.net_http_contracts.address}:(address="${cfg.ip}:${cfg.port}")' ->
          listen workbench(${fractalComponents.workbench})
    '';
  };
  exeSubnet = import (<fractalide> + "/support/vm/") {inherit pkgs support;
    contracts = allContracts;
    components = allComponents;
    exeSubnet = serviceSubnet;};
in
if fractalide == null
then publicNamespace
else {
  ###### interface
  options.services = {
    fractalide_workbench = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to run fractalide_workbench.
        '';
      };
      package = mkOption {
        type = types.package;
        default = exeSubnet;
        defaultText = "fractalComponents.workbench";
        example = literalExample "fractalComponents.workbench";
        description = ''
          Workbench example.
        '';
      };
    };
  };

  ###### implementation

  config = mkIf config.services.fractalide_workbench.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.services.fractalide_workbench = {
      description = "Workbench example";
      wantedBy = [ "multi-user.target" ];
      /*preStart =
        ''
        '';*/
      serviceConfig = {
        PermissionsStartOnly = true;
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}";
      };
    };
    users.extraUsers.fractalide_workbench = {
      description = "fractalide_workbench user";
      group = "fractalide_workbench";
      uid = config.ids.uids.fractalide_workbench;
    };
    users.extraGroups.fractalide_workbench.gid = config.ids.gids.fractalide_workbench;
  };
}
