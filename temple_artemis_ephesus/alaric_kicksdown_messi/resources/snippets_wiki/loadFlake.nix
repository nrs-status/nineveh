# -- DESC: load a nix flake
let 
  f = builtins.getFlake "flake:nineveh";
  g = builtins.getFlake "github:nrs-status/nineveh";
in
{
  "outputs1" = f.outputs;
  "outputs2" = g.outputs;
}
