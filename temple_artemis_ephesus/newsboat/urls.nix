{ pkgs, nameFromFilePath, resourcesFilePath, ... }:

let 
  urlsFileContent = builtins.readFile resourcesFilePath/urls.txt
pkgs.stdenv.mkDerivation {
  name = nameFromFilePath #gets passed "urls" by calling function
  src = null;

  installPhase = ''
    mkdir -p $out
    echo "${urlsFileContent}" > $out
  '';
}
