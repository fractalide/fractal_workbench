{ stdenv
  , buildFractalideComponent
  , genName, upkeepers
  , workbench_boolean
  , ...}:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  contracts = [ workbench_boolean ];
  depsSha256 = "1adwqbx2l77s352sj15h7n42q1yz3fshhf8sy426ri3x80mnhmlc";

  meta = with stdenv.lib; {
    description = "Component: NAND logic gate";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/maths/boolean/nand;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
