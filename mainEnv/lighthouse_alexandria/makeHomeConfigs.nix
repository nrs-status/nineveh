{lib, ...} @ inputs: let
  helpers = import ./. {inherit lib;};
in

  makeSingularConfig = { filepath, pkgs, home-manager-input, extraSpecialArgs }: home-manager-input.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [ filepath ];
    inherit extraSpecialArgs;
  };
  makeNameConfigPair = arg: { 
    name = helpers.getSuffixlessBasename arg.filepath; 
    value = makeSingularConfig arg
  };
in
  arg @ { filepath, pkgs, home-manager-input, extraSpecialArgs } : builtins.listToAttrs (map (makeNameConfigPair arg) (builtins.listFilesRecursive filepath))

