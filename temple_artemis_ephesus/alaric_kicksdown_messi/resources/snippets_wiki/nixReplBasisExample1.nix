# -- DESC: nix create a helper file to load into the nix repl to speed up testing with `:lf .` then `:a import ./thisfile.nix`
flakeInputs: rec {
  pkgs = import flakeInputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  lib = pkgs.lib;
  helpers = import ./lighthouse_alexandria {
    inherit pkgs;
    inherit lib;
    nixvim = flakeInputs.nixvim;
    systemType = "x86_64-linux";
  };
  topass = {
    inherit pkgs;
    nixvim = flakeInputs.nixvim;
    systemType = "x86_64-linux";
  };
}
