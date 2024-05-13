{
  homeVars = {
    #	mainUser = "sieyes";
    #	mainUserHomeDir = "/home/sieyes";
    pkgSets = [
      #the following configs from the temple_artemis_ephesus directory will be enabled; it uses the filename in temple_artemis_ephesus without the .nix suffix
      #"core"
      "cli"
      "git"
      "nixvim"
      "firefox"
      "multimedia"
      "games"
      "sway"
      "kitty"
      "fonts"
      "etc"
      "gammastep"
      "cloudwork"
      "gtk"
      #"custom_packages"
      "wofi"
      "anki"
    ];
  };
  nixosVars = {
    hostName = "nineveh";
    system = "x86_64-linux";
    timeZone = "America/Argentina/Buenos_Aires";
    mainUser = "sieyes";
    mainUserHomeDir = "/home/sieyes";

    modulesToEnable = [
      "home-manager"
      "keyRebindings"
      "bluetooth"
      "fish"
    ];
  };
}