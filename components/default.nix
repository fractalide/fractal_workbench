{ pkgs, support, allContracts, allComponents, ... }:
let
callPackage = pkgs.lib.callPackageWith (pkgs // support // allContracts // allComponents);
self = rec { # use one line only to insert a component (utils/new_component.py sorts this list)
  demo = callPackage ./demo {};
  demo_encrypt = callPackage ./demo/encrypt {};
}; # use one line only to insert a component (utils/new_component.py sorts this list)
in
self
