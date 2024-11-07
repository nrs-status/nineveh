# Concatenates files in current directory. This file gets imported by pkg.nix to define plugin config.
{lib, ...} @ inputs: let
  helpers = import ../../../../lighthouse_alexandria inputs;
  allNixFilesExceptFirstDefault = helpers.recursivelyListNixFilesExceptThoseInIgnoreList {
    dir = ./.;
    ignore = [./default.nix];
  };
  importAllInList = builtins.map (x: import x) allNixFilesExceptFirstDefault;
in
  lib.attrsets.mergeAttrsList importAllInList
