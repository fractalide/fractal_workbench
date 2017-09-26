{ edge, edges }:

edge {
  src = ./.;
  edges =  with edges; [];
  schema = with edges; ''
    struct WorkbenchBoolean {
      boolean @0 :Bool;
    }
  '';
}
