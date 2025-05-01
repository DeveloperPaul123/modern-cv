{
  description = "Typst resume flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    nixpkgs,
    typix,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      typixLib = typix.lib.${system};

      commonArgs = {
        typstSource = "main.typ";

        fontPaths = [
          "${pkgs.roboto}/share/fonts/truetype"
          "${pkgs.cascadia-code}/share/fonts/truetype"
          "${pkgs.font-awesome}/share/fonts/opentype"
          "${pkgs.source-sans}/share/fonts/truetype"
          "${pkgs.source-sans-pro}/share/fonts/truetype"
        ];

        virtualPaths = [];
      };
    in {
      devShells.default = typixLib.devShell {
        inherit (commonArgs) fontPaths virtualPaths;
        packages = [
          pkgs.just
          pkgs.typstyle
          pkgs.cascadia-code
          pkgs.roboto
          pkgs.font-awesome
          pkgs.source-sans
          pkgs.source-sans-pro
        ];
      };
    });
}
