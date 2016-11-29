{ subnet, components, contracts }:

subnet {
  src = ./.;
  flowscript = with components; with contracts; ''
  listen => listen http(${net_http_components.http})
  db_path => input clone(${ip_clone})
  clone() clone[1] -> db_path get(${app_todo_components.todo_get})
  clone() clone[2] -> db_path post(${app_todo_components.todo_post})
  clone() clone[3] -> db_path delete(${app_todo_components.todo_delete})
  clone() clone[4] -> db_path patch(${app_todo_components.todo_patch})

  http() GET[/todos/.+] -> input get() response -> response http()
  http() POST[/todos/?] -> input post() response -> response http()
  http() DELETE[/todos/.+] -> input delete() response -> response http()
  http() PATCH[/todos/.+] -> input patch()
  http() PUT[/todos/.+] -> input patch() response -> response http()
  '';
}
