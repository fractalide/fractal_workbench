{ stdenv
  , buildFractalideSubnet
  , generic_text
  , net_http_components
  , net_http_contracts
  , ...}:

buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   net_http(${net_http_components.http})
   '${net_http_contracts.address}:(address="0.0.0.0:8000")' -> listen net_http()

   '${generic_text}:(text="Hello world")' -> option world(${net_http_components.raw_text})
   '${generic_text}:(text="Hello fractalide")' -> option fractalide(${net_http_components.raw_text})
   '${generic_text}:(text="Hello fractalide with ID")' -> option fractalideID(${net_http_components.raw_text})
   '${generic_text}:(text="Hello fractalide with Post!")' -> option fractalideP(${net_http_components.raw_text})

   net_http() GET[^/$] -> input world() output -> response net_http()
   net_http() GET[^/frac] -> input fractalide() output -> response net_http()
   net_http() GET[^/frac/.+] -> input fractalideID() output -> response net_http()

   net_http() POST[/frac] -> input fractalideP() output -> response net_http()
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
