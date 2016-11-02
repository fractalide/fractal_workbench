{ stdenv, buildFractalideSubnet, upkeepers
  , workbench_nand
  , maths_boolean_print
  , workbench_boolean
  , encrypt
  ,...}:

  buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   '${workbench_boolean}:(boolean=true)' -> a enc_nand(${encrypt workbench_nand}) output -> input io_print(${maths_boolean_print})
   '${workbench_boolean}:(boolean=true)' -> b enc_nand()
     '';

   meta = with stdenv.lib; {
    description = "Subnet: testing file for sjm";
    homepage = https://github.com/fractalide/frac_workbench;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie ];
  };
}
