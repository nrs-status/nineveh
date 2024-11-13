{lib, ...} @ inputs: let
  helpers = import ./. {inherit lib;};
in
  dirPath: let
    allNixFilesGatheredRecursively = helpers.recursivelyListNixFilesExceptThoseInIgnoreList {
      dir = dirPath;
      ignore = [];
    };
    filteringLeavingOnlyFilesNamedPkgDotNix = lib.filter (filePath: lib.hasSuffix "customPackaging.nix" filePath) allNixFilesGatheredRecursively;
    unpackASetsContainedInCustomPackagingFiles = map (x: import x inputs) filteringLeavingOnlyFilesNamedPkgDotNix;
  in
    lib.foldl (a: b: a // b) {} unpackASetsContainedInCustomPackagingFiles
# debug version
# {lib, ...} @ inputs: let
#   helpers = import ./. {inherit lib;};
#   recursivelyImportAllFilesNamedPkgDotNix = dirPath: let
#     allNixFilesGatheredRecursively = helpers.recursivelyListNixFilesExceptThoseInIgnoreList {
#       dir = dirPath;
#       ignore = [];
#     };
#     filteringLeavingOnlyFilesNamedPkgDotNix = lib.filter (filePath: lib.hasSuffix "pkg.nix" filePath) allNixFilesGatheredRecursively;
#     listOfParentDirs = map (x: baseNameOf (builtins.dirOf x)) filteringLeavingOnlyFilesNamedPkgDotNix;
#     attrsFromParentDirNPkgFilePairs = helpers.zipListsIntoAttrs listOfParentDirs filteringLeavingOnlyFilesNamedPkgDotNix;
#     attrsOfPackages = builtins.mapAttrs (name: value: import value inputs) attrsFromParentDirNPkgFilePairs;
#   in {
#     inherit helpers;
#     inherit attrsFromParentDirNPkgFilePairs;
#     inherit allNixFilesGatheredRecursively;
#     inherit filteringLeavingOnlyFilesNamedPkgDotNix;
#     inherit listOfParentDirs;
#     inherit attrsOfPackages;
#     inherit inputs;
#   };
# in
#   recursivelyImportAllFilesNamedPkgDotNix

