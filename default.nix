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
    orgpress = super.elpaBuild {
      pname = "orgpress";
      version = "0.3";
      src = ./orgpress.el;
    };
  };
  emacsWithPackages = ((pkgs.emacsPackagesFor pkgs.emacs-nox).overrideScope' overrides).emacsWithPackages;

  myEmacs = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
    epkgs.org-contrib
    epkgs.orgpress
    epkgs.nano-theme
    scala-mode
    haskell-mode
    go-mode
    htmlize
    clojure-mode
    purescript-mode
    epkgs.ox-tufte
  ]));
in
myEmacs
