{pkgs ? import ./nixpkgs.nix }:

let
  ox-tufte = builtins.fetchurl {
    url = "https://github.com/jcouyang/ox-tufte/archive/4d63c96ac269c119eed47ef453523619863a4fe8.zip";
    sha256 = "1jvxd82jcv1vvrj3kz2k0l8699d2k43jrrr9gvppggxdn7rykhfl";
  };
  overrides = self: super: {
    ox-tufte = super.ox-tufte.override {
      elpaBuild = args: super.elpaBuild (args // {
          src = ox-tufte;
        });
    };
    orgpress = super.melpaBuild {
      pname = "orgpress";
      version = "0.0.1";
      src = ./.;
      recipe = pkgs.writeText "recipe" ''
        (orgpress :fetcher github :repo "jcouyang/orgpress")
        '';
    };
  };
  emacsWithPackages = ((pkgs.emacsPackagesGen pkgs.emacs-nox).overrideScope' overrides).emacsWithPackages;
  myEmacs = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
    epkgs.orgpress
    scala-mode
    haskell-mode
    htmlize
    color-theme-modern
    clojure-mode
    purescript-mode
    epkgs.ox-tufte
    epkgs.org-plus-contrib
  ]));
in
myEmacs
