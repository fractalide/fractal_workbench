{ subnet, components, contracts }:

subnet {
  src = ./.;
  flowscript = with components; with contracts; ''
  '${net_http_contracts.address}:(address="127.0.0.1:8000")' -> listen workbench(${workbench})
  '${path}:(path="${builtins.getEnv "HOME"}/todos.db")' -> db_path workbench()
  '';
}
