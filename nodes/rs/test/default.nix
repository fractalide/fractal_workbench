{ subgraph, imsg, nodes, edges }:
let
  NetHttpAddress = imsg {
    class = edges.NetHttpEdges.NetHttpAddress;
    text = ''(address="127.0.0.1:8000")'';
  };
  FsPath = imsg {
    class = edges.FsPath;
    text = ''(path="${builtins.getEnv "HOME"}/todos.db")'';
  };
in
subgraph {
  src = ./.;
  flowscript = with nodes.rs; ''
  '${NetHttpAddress}' -> listen workbench(${workbench})
  '${FsPath}' -> db_path workbench()
  '';
}
