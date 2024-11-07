# -- DESC: example of evaluating a nix command from the command line
nix eval --impure --expr "let p = import <nixpkgs> {}; in p.lib.getExe p.hello"
