{
  description = "Sparrow's aesthetic.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {

          everforest = pkgs.stdenv.mkDerivation rec {
            name = "Evereforest and OpenProps";
            version = builtins.substring 0 8 lastModifiedDate;
            src = ./.;
            buildInputs = with pkgs; [nodePackages.lightningcss];
            phase = "installPhase";
            installPhase = ''
              mkdir -p $out/static.css
              echo Not done yet.
              ''
          }

          nativeBuildInputs = with pkgs; [ ];

          buildInputs = with pkgs; [ ];
        };
      }
    );
}
