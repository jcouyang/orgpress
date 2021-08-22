let pkgs = import ./nixpkgs.nix;
    myEmacs = import ./default.nix {};
in pkgs.dockerTools.streamLayeredImage {
  name = "ghcr.io/jcouyang/orgpress";
  tag = "latest";
  created = "now";
  contents = [pkgs.bash myEmacs];
  config = {
    Entrypoint = [ "/bin/emacs"];
    Cmd = [ "-batch" "-l" "orgpress" "-f" "org-publish-all" ];
    WorkingDir = "/blog";
  };
}
