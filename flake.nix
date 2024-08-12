{
  description = "A flake for github-action-codingchallenge";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    utils,
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
              buildInputs = [
              ];

              buildPhase = ''
                sed -i 's/${version}/${nextVersion}/' document.txt
              '';

              installPhase = ''
                mkdir -p $out/
                mv document.txt $out/document.txt
              '';
            };
          };
        }
    );
}
