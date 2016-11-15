{ stdenv
  , buildFractalideSubnet
  , net_http_components
  , app_todo_components
  , ip_clone
  , ...}:
buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   listen => listen http(${net_http_components.http})
   db_path => input clone(${ip_clone})
   clone() clone[1] -> db_path get(${app_todo_components.get})
   clone() clone[2] -> db_path post(${app_todo_components.post})
   clone() clone[3] -> db_path delete(${app_todo_components.delete})
   clone() clone[4] -> db_path patch(${app_todo_components.patch})

   http() GET[/todos/.+] -> input get() response -> response http()
   http() POST[/todos/?] -> input post() response -> response http()
   http() DELETE[/todos/.+] -> input delete() response -> response http()
   http() PATCH[/todos/.+] -> input patch()
   http() PUT[/todos/.+] -> input patch() response -> response http()
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
