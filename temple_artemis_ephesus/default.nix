{lib, helpers, selfpath, ...} @ inputs: let
  allNixFilesExceptFirstDefault = helpers.recursivelyListNixFilesExceptThoseInIgnoreList {
    dir = ./.;
    ignore = [./default.nix];
  };
  filteringKeepingDefaultDotNixFiles = lib.filter (x: lib.hasSuffix "default.nix" x) allNixFilesExceptFirstDefault;
  topLevelFilter = x: baseNameOf (dirOf (dirOf x)) == "temple_artemis_ephesus";
  filteringKeepingTopLevelDefaultFiles = builtins.filter topLevelFilter filteringKeepingDefaultDotNixFiles;
  
  #toplevel paths
  #grab all nix files at path
  #separate default and make list from it
  #concat other packages to default list
  #mke derivation from this list
in
  # @NOTE: Additional modules must be at least staged in git
  {
    imports = filteringKeepingTopLevelDefaultFiles;
  }
