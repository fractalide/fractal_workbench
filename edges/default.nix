{ buffet }:
let
  callPackage = buffet.pkgs.lib.callPackageWith ( buffet.support // buffet );
in
rec {
  workbench_boolean = callPackage ./workbench/boolean {};
}
