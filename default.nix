{
  fractalide ? import <fractalide> {}
  , pkgs ? fractalide.pkgs
  , support ? fractalide.support
  , contracts ? fractalide.contracts
  , components ? fractalide.components
}:
let
  exeSubnet = fractalComponents.workbench;
  fractalContracts = import ./contracts {inherit pkgs support allContracts;};
  fractalComponents = import ./components {inherit pkgs support allContracts allComponents;};
  allContracts = contracts // fractalContracts;
  allComponents = components // fractalComponents;

  plugMeIntoFractalide = { components = fractalComponents; contracts = fractalContracts; };
  runMeFromFractal = import (<fractalide> + "/support/vm/") {inherit pkgs support;
    contracts = allContracts;
    components = allComponents;
    exeSubnet = exeSubnet;};
  result = if fractalide == null
    then plugMeIntoFractalide
    else runMeFromFractal;
in
result
