{ buffet }:
let
  callPackage = buffet.pkgs.lib.callPackageWith ( buffet.support // buffet );
in
rec {
  WorkbenchBoolean = callPackage ./workbench/boolean {};
}
