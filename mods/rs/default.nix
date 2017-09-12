{ buffet }:
let
  verbose = buffet.verbose;
  release = buffet.release;
  fetchzip = buffet.pkgs.fetchzip;
  mkRustCrate = buffet.support.rs.mkRustCrate;
in
import ./crates { inherit mkRustCrate fetchzip release verbose; }
