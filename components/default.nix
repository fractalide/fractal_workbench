{ buffet }:

let
callPackage = buffet.pkgs.lib.callPackageWith (buffet // buffet.support );
self = rec { # use one line only to insert a component (utils/new_component.py sorts this list)
  workbench = callPackage ./workbench {};
  test = callPackage ./test {};
}; # use one line only to insert a component (utils/new_component.py sorts this list)
in
self
