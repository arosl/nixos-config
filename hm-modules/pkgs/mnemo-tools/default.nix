{ pkgs }:
let
  # Fetch the source from GitHub
  src = pkgs.fetchFromGitHub {
    owner = "hsorbo";
    repo = "mnemo-tools";
    rev = "d46a071";
    sha256 = "rd+/hCsf8ImulqsJNd+UT7SEMuq+2a5wWcBKqsoPi/c=";
  };
in
  with pkgs;
    stdenv.mkDerivation rec {
      pname = "mnemo-tools";
      version = "1.0.0";

      inherit src;

      installPhase = ''
        mkdir -p $out/bin
        cp mnemofetch $out/bin/
      '';

      meta = with lib; {
        description = "mnemo-tools - download data (.dmp) from your mnemo with mnemofetch";
        license = licenses.bsd3;
        platforms = platforms.unix;
      };
    }
