# -- DESC: nix provide an overlay for haskellPackages or haskell.packages using .override
haskellPackages.override { overrides = self: super: { ncurses = pkgs.haskell.lib.unmarkBroken super. ncurses; }; }
haskell.packages.ghc910.override { overrides = self: super: { ... }; };

-- application:

    overlayToFixLiquidFixpoint = final: prev: {
      haskell =
        prev.haskell
        // {
          packages =
            prev.haskell.packages
            // {
              ghc964 =
                prev.haskell.packages.ghc964
                // prev.haskell.packages.ghc964.override {
                  overrides = final2: prev2: {
                    liquid-fixpoint = prev2.liquid-fixpoint.overrideAttrs (oldAttrs: {meta.broken = false;});
                  };
                };
            };
        };
    };
