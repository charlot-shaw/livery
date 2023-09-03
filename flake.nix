{
  description = "Sparrow's CSS base.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    utils.url = github:numtide/flake-utils;
    openprops = {
      url = "https://unpkg.com/open-props@1.5.15/open-props.min.css";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, openprops, ... }:
    utils.lib.eachDefaultSystem (system:
      let 
        lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          livery = pkgs.stdenv.mkDerivation rec {
            pname = "livery";
            description = "Everforest and openprops";
            version = builtins.substring 0 8 lastModifiedDate;
            system = system;
            src = builtins.path {path = ./.;
                                 name = "livery";};
            buildInputs = with pkgs; [lightningcss];
            phase = "buildPhase";

            buildPhase = ''
              mkdir work
              cp  ${openprops} work/op.css
              cp $src/src/everforest.css work/custom.css
              lightningcss --minify --bundle --nesting --targets '>= 0.25%' work/custom.css -o $out/css/base.css
            '';
          };
        };

        devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [lightningcss];
          };
      }
    );
}
