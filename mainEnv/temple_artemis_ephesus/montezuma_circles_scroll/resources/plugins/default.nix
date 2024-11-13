# Concatenates files in current directory. This file gets imported by pkg.nix to define plugin config.
{lib, helpers, pkgs} @ inputs: let
  allNixFilesExceptFirstDefault = helpers.recursivelyListNixFilesExceptThoseInIgnoreList {
    dir = ./.;
    ignore = [./default.nix];
  };
  importAllInList = builtins.map (x: import x { inherit pkgs; }) allNixFilesExceptFirstDefault;
in
  lib.attrsets.mergeAttrsList importAllInList
