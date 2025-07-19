{ pkgs, ... }:

{
  env.RUST_LOG = "debug";

  packages = [ pkgs.cargo-watch pkgs.bacon ];

  languages.rust = {
    enable = true;
    mold.enable = true;
  };

  processes = { cargo-watch.exec = "cargo-watch -x run"; };

  tasks = {
    "{{crate_name}}:build".exec = "cargo build";
    "devenv:enterShell".after = [ "{{crate_name}}:build" ];
  };

  enterTest = ''
    cargo test
  '';

  git-hooks.hooks = {
    clippy.enable = true;
    clippy.settings.denyWarnings = true;
  };
}
