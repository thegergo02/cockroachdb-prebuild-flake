{
  description = "The best of Auth0 and Keycloak combined.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { 
        system = "x86_64-linux"; 
        config = { allowUnfree = true; };
      };

      stdenv.mkDerivation rec {
        name = "zitadel-${version}";
        version = "v2.0.0-v2-alpha.33";

        src = pkgs.fetchurl {
                url = "https://github.com/zitadel/zitadel/releases/download/${version}/zitadel_Linux_x86_64.tar.gz";
                sha256 = "sha256-HpLu3cXQ+lUmnvrqjU/SEnGzouSO0ZSiwn1NIBNHSVM=";
        };
        sourceRoot = ".";
        
        buildInputs = [ cockroachdb ];

        installPhase = ''
        install -m755 -D zitadel $out/bin/zitadel
        '';

        meta = with lib; {
                homepage = "https://zitadel.com/";
                description = self.description;
                platforms = platforms.linux;
        };
      };
  };
}

# github.com/thegergo02/zitadel-prebuild-flake