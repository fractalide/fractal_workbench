{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  edges = with edges; [ net_http_edges.net_http_address fs_path ];
  flowscript = with nodes; with edges; ''
  '${net_http_edges.net_http_address}:(address="127.0.0.1:8000")' -> listen workbench(${workbench})
  '${fs_path}:(path="${builtins.getEnv "HOME"}/todos.db")' -> db_path workbench()
  '';
}
