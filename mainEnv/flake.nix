{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvimFlakeInput.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixvimFlakeInput }:
    let
      # supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        inherit system;
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs, system}: {
        default = 
          let 
            helpers = import ./lighthouse_alexandria { lib = pkgs.lib; };
            nixvimDrv = import ./temple_artemis_ephesus/montezuma_circles_scroll { inherit pkgs; inherit nixvimFlakeInput; inherit system; inherit helpers; };
            config = import ./CONFIG.nix { inherit pkgs; nixvimPkg = nixvimDrv; };
          in 
            pkgs.mkShell {
          packages = config.packageSetToLoad;

          SUDO_EDITOR = pkgs.lib.getExe nixvimDrv;

	  shellHook = ''
export name=mainenvshell

if [ $(date -d "2024/11/15" +%s) -lt $(date +%s) ]; then
  while true; do echo "WARNING CLEAR PIECE OF SHELLHOOK CONTAINING THIS CODE OR EXTEND DATE"; sleep 2; done
else 
  echo "loading lean systools build; temporary solution until i have time to package it in a form more suited for long term usage"
  export PATH=$PATH:/home/seba/app/newFramework/systools/.lake/build/bin
fi
'';
        };
      });
    };
}
