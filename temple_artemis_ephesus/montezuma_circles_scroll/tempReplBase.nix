{ pkgs }:
let
	nixvimflake = builtins.getFlake github:nix-community/nixvim;
in
	import ./customPackaging.nix { inherit pkgs; nixvim = nixvimflake; system = "x86_64-linux"; }
