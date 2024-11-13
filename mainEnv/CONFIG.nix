{ pkgs, nixvimPkg }:
{
  packageSetToLoad = import ./pyramid_giza/workEnv.nix { inherit pkgs; inherit nixvimPkg; };
}
