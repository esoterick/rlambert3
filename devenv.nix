{pkgs, ...}: {
  env.GREET = "rlambert3";
  packages = with pkgs; [git zola alejandra nil yamllint shellcheck taplo];
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
    zola --version
  '';

  languages.nix.enable = true;

  pre-commit.hooks.shellcheck.enable = true;
  pre-commit.hooks.alejandra.enable = true;
  pre-commit.hooks.yamllint.enable = true;
  pre-commit.hooks.taplo.enable = true;

  # processes.ping.exec = "ping example.com";
}
