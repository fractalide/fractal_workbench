{ pkgs, support, allContracts, allComponents, ... }:
let
callPackage = pkgs.lib.callPackageWith (pkgs // support // allContracts // allComponents);
self = rec { # use one line only to insert a component (utils/new_component.py sorts this list)
  workbench = callPackage ./workbench {};
  workbench_encrypt = callPackage ./workbench/encrypt {};
}; # use one line only to insert a component (utils/new_component.py sorts this list)
in
self
