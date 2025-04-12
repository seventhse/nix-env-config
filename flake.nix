{
  description = "Full developer env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            zsh
            git
            nodejs_22
            pnpm_10
            python3
            pkg-config
            rust-bin.stable.latest.default
            eza
          ];

          shellHook = ''
            alias ls=eza
            echo "🔧 Development environment ready!"
          '';
        };
      });
}