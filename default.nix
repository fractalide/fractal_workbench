{
  fractalide ? import <fractalide> {}
  , pkgs ? fractalide.pkgs
  , support ? fractalide.support
  , contracts ? fractalide.contracts
  , components ? fractalide.components
  , subnet ? "test" #<- this is your test component, only change this line
}:
let
  isValidSubnet = (builtins.head (pkgs.lib.attrVals [subnet] fractalComponents));
  defaultSubnet = if (builtins.isAttrs isValidSubnet) then isValidSubnet else null;
  fractalContracts = import ./contracts {inherit pkgs support allContracts;};
  fractalComponents = import ./components {inherit pkgs support allContracts allComponents;};
  allContracts = contracts // fractalContracts;
  allComponents = components // fractalComponents;
  plugMeIntoFractalide = { components = fractalComponents; contracts = fractalContracts; };
  fvm = import (<fractalide> + "/support/fvm/") {inherit pkgs support;
    contracts = contracts;
    components = components;
  };
  result = if fractalide == null
    then plugMeIntoFractalide
    else pkgs.writeTextFile {
      name = defaultSubnet.name;
      text = "${fvm}/bin/fvm ${defaultSubnet}";
      executable = true;
    };
in
result
