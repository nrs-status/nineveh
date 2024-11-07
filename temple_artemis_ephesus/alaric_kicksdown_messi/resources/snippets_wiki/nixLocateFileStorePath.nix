# -- DESC: nix get the store path for a particular package from a given flake
nix
repl
:lf <flake_path> 
pkgs = outputs.nixosConfigurations.HOSTNAME.pkgs
"${pkgs.DESIRED_PACKAGE}
