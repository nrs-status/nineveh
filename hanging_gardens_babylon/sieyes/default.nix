{
  pkgVars = {
    pkgSets = [
      #the following configs from the temple_artemis_ephesus directory will be enabled; it uses the filename in temple_artemis_ephesus without the .nix suffix
      #"core"
      "cli"
      "cli-minimal"
      "cli-extended"
      "monitoring"
      "git"
      "nixvim"
      # to fix     "doom-emacs"
      # "emacs"
      "firefox"
      "multimedia"
      "games"
      "sway"
      "kitty"
      "fonts"
      "etc"
      #programming languages
#      "php"
      "javascript"
      "typescript"
      "python"
      "haskell"
      "lean4"
      "agda"
      #"clojure"
#      "racket"
      #"scala"
#      "curry"
#      "prolog"


#      "androidDev"
      "buildTools"

      "gammastep"
#      "cloudwork"
      "gtk"
      #"custom_packages"
      "wofi"
      "anki"
      "navi"

#      "ai"
    ];
  };
  nixosVars = {
    timeZone = "America/Argentina/Buenos_Aires";

    modulesToEnable = [
      "home-manager"
      "keyRebindings"
      "bluetooth"
      #"fish"
      "firewall"

      #enable only one of the following at a time
      #"podman"
      "docker"

      #"vault-server"

      "etc"
    ];
  };
}
