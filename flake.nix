{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    vault-secrets = {
      url = "github:serokell/vault-secrets/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    vault-secrets,
    nix-doom-emacs-unstraightened,
    emacs-overlay,
    ...
  }: let
    env = import hanging_gardens_babylon/nineveh;
    system = env.nixosVars.system;
    overlaylessNixpkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    hostName = env.nixosVars.hostName;
    helpers = import ./lighthouse_alexandria {
      pkgs = overlaylessNixpkgs;
      inherit system;
      lib = overlaylessNixpkgs.lib;
      nixvim = inputs.nixvim;
    }; #all of these are passed because helpers contains the function that builds derivations from pkg.nix files in temple
    defaultOverlay = final: prev: helpers.createAttrsFromCustomPackagingFiles ./temple_artemis_ephesus;
    pkgs = import nixpkgs {
        system = env.nixosVars.system;
        config.allowUnfree = true;
        overlays = [defaultOverlay];
      };
  in {
    overlays.default = defaultOverlay;
    packages = pkgs;
#    packages."x86_64-linux" = {
#      nixvim = pkgs.nixvim
#    };
    apps."x86_64-linux" = {
      "nvim" = {
        type = "app";
        program = "${self.packages.nixvim}/bin/nvim";
      };
      "test" = {
        type = "app";
        program = pkgs.lib.getExe self.packages.hello;
      };
    };
    nixosConfigurations = {
      #the following variable name must be the current host's variable name, otherwise will raise an error
      ${hostName} = nixpkgs.lib.nixosSystem {
        system = env.nixosVars.system;
        specialArgs = env;
        modules = [
          {
            networking.hostName = env.nixosVars.hostName;
            time.timeZone = env.nixosVars.timeZone;
            nixpkgs.overlays = [
              emacs-overlay.overlay
              (final: prev: {
              })
              self.overlays.default
            ];
          }
          ./zeus_olympia
          #the vault-secrets.nixosModules.vault-secrets module call has this odd structure because the first vault-secrets is the flake from our inputs, it just turns out that the flake has the same name as the nixosModules attribute `vault-secrets`. Now, the flake `vault-secrets` has the attribute `nixosModules` because it is where it publishes a nixos module; in contrast see the flake `home-manager` that publishes, not only a nixosModules attribute but also a darwin module. The flake `nixvim` publishes a nixos module, a darwin module, and a home manager module.
          #furthermore, it ends with `.vault-secrets`, an attribute of nixosModules, because it is possible to have a flake that publishes multiple nixosModules
          vault-secrets.nixosModules.vault-secrets
          {
            options.nineveh.system.home-manager.enable = pkgs.lib.mkEnableOption "home manager";
            config.${hostName}.system = helpers.stringListToEnabledOptions env.nixosVars.modulesToEnable; #in charge of setting the nixosModule options
          }
          # make home-manager as a module of nixos so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          ({
            config,
            lib,
            ...
          }: let
            inherit env;
            inherit hostName;
            mainUser = env.nixosVars.mainUser;
          in {
            home-manager = lib.mkIf config.${hostName}.system.home-manager.enable {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = env;
              users.${mainUser} = {
                imports = [
                  ./temple_artemis_ephesus
                  nixvim.homeManagerModules.nixvim
                  nix-doom-emacs-unstraightened.hmModule
                ];
                home = {
                  username = mainUser;
                  homeDirectory = "/home/${mainUser}";
                  stateVersion = "23.11";
                };
                programs.home-manager.enable = true;
                ${hostName}.home = helpers.stringListToEnabledOptions env.homeVars.pkgSets;
              };
            };
          })
        ];
      };
    };
  };
}
