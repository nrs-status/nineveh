{ lib, ... }@inputs:
let
  recursivelyListNixFilesExceptThoseInIgnoreList = { ignore, dir }:
    let
      trueIfIsNixFileButNotInIgnoreList = ( filePath:
      lib.hasSuffix ".nix" filePath
      && ! ( builtins.elem filePath ignore )
      );
      filteredRecursivelyGeneratedListOfFiles = lib.filter trueIfIsNixFileButNotInIgnoreList ( lib.filesystem.listFilesRecursive dir );
    in
    filteredRecursivelyGeneratedListOfFiles;
  recursivelyListedFilesInThisDir = recursivelyListNixFilesExceptThoseInIgnoreList {
    dir = ./.;
    ignore = [];
  };
  getSuffixlessBasename = filePath: lib.removeSuffix ".nix" (baseNameOf filePath);
  makeNameNImportedFilePair = filePath: { name = getSuffixlessBasename filePath; value = import filePath inputs; };
  list_nameNImportedFilePairs = map makeNameNImportedFilePair recursivelyListedFilesInThisDir;
  attrs_nameNImportedFile = builtins.listToAttrs list_nameNImportedFilePairs;
in
{
  inherit recursivelyListNixFilesExceptThoseInIgnoreList;
  dirToNameFileAttrs = dir : builtins.listToAttrs (map makeNameNImportedFilePair (lib.filesystem.listFilesRecursive dir));

} // attrs_nameNImportedFile
