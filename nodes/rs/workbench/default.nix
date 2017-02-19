{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes.rs; ''
  listen => listen http(${net_http_nodes.http})
  db_path => input clone(${msg_clone})
  clone() clone[1] -> db_path get(${app_todo_nodes.todo_get})
  clone() clone[2] -> db_path post(${app_todo_nodes.todo_post})
  clone() clone[3] -> db_path delete(${app_todo_nodes.todo_delete})
  clone() clone[4] -> db_path patch(${app_todo_nodes.todo_patch})

  http() GET[^/halt] -> halt http()
  http() GET[/todos/.+] -> input get() response -> response http()
  http() POST[/todos/?] -> input post() response -> response http()
  http() DELETE[/todos/.+] -> input delete() response -> response http()
  http() PATCH[/todos/.+] -> input patch()
  http() PUT[/todos/.+] -> input patch() response -> response http()
  '';
}
