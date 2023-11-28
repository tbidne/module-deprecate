{
  description = "Module deprecation example";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nix-hs-utils.url = "github:tbidne/nix-hs-utils";
  outputs =
    inputs@{ flake-parts
    , nixpkgs
    , nix-hs-utils
    , self
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = { pkgs, ... }:
        let
          hlib = pkgs.haskell.lib;
          ghc-version = "ghc963";
          compiler = pkgs.haskell.packages."${ghc-version}";
          mkPkg = returnShellEnv:
            nix-hs-utils.mkHaskellPkg {
              inherit compiler pkgs returnShellEnv;
              devTools = [ ];
              name = "module-deprecate";
              root = ./.;
            };
        in
        {
          packages.default = mkPkg false;
          devShells.default = mkPkg true;
        };
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
