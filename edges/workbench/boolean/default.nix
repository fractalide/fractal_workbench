{ edge, edges }:

edge {
  src = ./.;
  edges =  with edges; [];
  schema = with edges; ''
  @0xbde554c96bf60f36;

  struct WorkbenchBoolean {
    boolean @0 :Bool;
  }
  '';
}
