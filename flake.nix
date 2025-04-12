{
  description = "Full developer env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            nodejs_22
            pnpm_10
            zsh
            python3
            rustc
            cargo
          ];

          shellHook = ''
            echo "🔧 Development environment ready!"
          '';
        };
      });
}
