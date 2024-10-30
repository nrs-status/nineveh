#!/usr/bin/env bash
#Takes a hash, builds a system configuration from the system flake at that git hash, then outputs the location of the build

currentPath=$PWD

cd /tmp
mkdir tmpBuildDir
cd tmpBuildDir
nixos-rebuild build --flake path:/etc/nixos?rev="$1"
outputPath=$(readlink -f result)
rm result
cd ..
rm -r tmpBuildDir
cd "$currentPath"

echo "$outputPath"
