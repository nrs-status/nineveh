{ pkgs ? import <nixpkgs> {}
, fetchFromGitHub
, stdenv
, ... }:
pkgs.oh-my-fish.overrideAttrs (finalAttrs: previousAttrs: {
  src = fetchFromGitHub {
    owner = "oh-my-fish";
    repo = "oh-my-fish";
    rev = "d427501";
    hash = "sha256-dwaA1bJiYcjpWQa4+5R79RohcmKngOHEe7plZt2spr0=";
  };

  postInstall = ''
    $out/bin/omf-install kawasaki
    '';
})
