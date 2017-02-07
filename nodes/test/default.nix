{ subgraph, imsgs, nodes, edges }:

subgraph rec {
  src = ./.;
  imsg = imsgs {
    edges = with edges; [ NetHttpEdges.NetHttpAddress FsPath];
  };
  flowscript = with nodes; with edges; ''
  '${imsg}.NetHttpAddress:(address="127.0.0.1:8000")' -> listen workbench(${workbench})
  '${imsg}.FsPath:(path="${builtins.getEnv "HOME"}/todos.db")' -> db_path workbench()
  '';
}
