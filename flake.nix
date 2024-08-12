{
  description = "A flake for github-action-codingchallenge";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = {
    nixpkgs,
    utils,
    nix-filter,
    ...
    }:
    utils.lib.eachSystem ["x86_64-linux"] (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages = rec {

            default = version-replace;

            version-replace = pkgs.stdenv.mkDerivation rec {
              name = "version-replace";
              version = "1";
              nextVersion = "2";
              src = ./.;

              buildPhase = ''
                sed -i 's/${version}/${nextVersion}/' document.txt
              '';

              installPhase = ''
                mkdir -p $out/
                mv document.txt $out/document.txt
              '';
            };

            version-replace-container = pkgs.dockerTools.buildImage {
              name = "ghcr.io/rschardt/version-replace-container";
              tag = "latest";
              copyToRoot = (pkgs.buildEnv {
                name = "version-replace-container-layer-0";
                paths = [
                  (nix-filter {
                    root = ./.;
                    include = [
                      ./document.txt
                    ];
                  })
                  pkgs.coreutils
                  pkgs.bashInteractive
                ];
                pathsToLink = [ "/" ];
              });
              config = {
                Cmd = [ "/bin/bash" ];
              };
            };
          };
        }
    );
}
