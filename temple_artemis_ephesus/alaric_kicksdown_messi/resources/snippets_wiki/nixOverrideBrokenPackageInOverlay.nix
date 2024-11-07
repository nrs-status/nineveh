# -- DESC: nix provide an overlay where we override a package's `broken` attribute so that it will evaluate without throwing an error. Uses a scope override and haskellPackages.extend
localFlake: rec {
  system = "x86_64-linux";
  overlaysSetup = rec {
    brokenOverride = oldAttrs: {meta.broken = false;};
    pkgScopeOverride = final: prev: {liquid-fixpoint = prev.liquid-fixpoint.overrideAttrs brokenOverride;};
    liquidPointFixOverlay = final: prev: {haskellPackages = prev.haskellPackages.extend pkgScopeOverride;};
    overlayContainingMyNixvim = localFlake.overlays.default;
  };
  pkgs = import localFlake.inputs.nixpkgs {
    inherit system;
    overlays = [
      overlaysSetup.liquidPointFixOverlay
      overlaysSetup.overlayContainingMyNixvim
    ];
  };
}
