{ stdenv
  , buildFractalideSubnet
  , net_http_contracts
  , workbench
  , path
  , ...}:

buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   '${net_http_contracts.address}:(address="127.0.0.1:8000")' -> listen workbench(${workbench})
   '${path}:(path="${builtins.getEnv "HOME"}/todos.db")' -> db_path workbench()
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
