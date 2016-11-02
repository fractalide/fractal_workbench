{ fractalide ? import <fractalide> {}
  , pkgs ? fractalide.pkgs
  , support ? fractalide.support
  , contracts ? fractalide.contracts
  , components ? fractalide.components
  , fractalide_user ? null
  , config_file ? null}:
let
  ### ------------------------------
  plugMeIntoFractalideUpstream = allComponents.workbench_nand;
  # ^^^ this component is the top-level component you want to share with the rest of the community.
  # typically this component will only expose virtual subnet ports.
  runMeFromThisFrac = allComponents.workbench_test;
  # ^^^ this component typically contains your test IIPs, not really for sharing
  ### you shouldn't need to change anything else!
  ### ------------------------------
  encrypt = support.encryptComponent {fractalide_user = fractalide_user; keybase_config_file = config_file;};
  allContracts = contracts // import ./contracts {inherit pkgs support allContracts;};
  allComponents = components
                  // import ./components {inherit pkgs support allContracts allComponents;}
                  // {encrypt = encrypt;};
  result = if fractalide == null
    then plugMeIntoFractalideUpstream
    else import (<fractalide> + "/support/vm/") {inherit pkgs support;
      contracts = allContracts;
      components = allComponents;
      exeSubnet = runMeFromThisFrac;};
in
  result
