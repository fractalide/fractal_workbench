{ stdenv
  , buildFractalideSubnet
  , maths_boolean_print
  , maths_boolean_nand
  , workbench_boolean
  , encrypt
  , ...}:

buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   '${workbench_boolean}:(boolean=true)' -> a nand(${encrypt maths_boolean_nand}) output -> input io_print(${maths_boolean_print})
   '${workbench_boolean}:(boolean=true)' -> b nand()
   '';
   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
