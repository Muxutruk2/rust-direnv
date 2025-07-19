{ pkgs, ... }:

{
  env.RUST_LOG = "debug";

  packages = [ pkgs.cargo-watch pkgs.bacon ];

  enterShell = ''
    echo Development Shell for {{crate_name}} initialized.
    echo Cargo version:
    cargo --version
    echo Building project...
    cargo build
  '';

  languages.rust = {
    enable = true;
    mold.enable = true;
  };

  processes = { cargo-watch.exec = "cargo-watch -x run"; };

  tasks = {
    "{{crate_name}}:build" = {
      exec = "cargo build";
      execIfModified = [ "src/**/*.rs" "Cargo.toml" "Cargo.lock" ];
    };

    "{{crate_name}}:check" = { exec = "cargo check"; };

    "{{crate_name}}:lint" = {
      exec = ''
        cargo fmt -- --check
        cargo clippy -- -D warnings
      '';
      execIfModified = [ "src/**/*.rs" ];
    };

    "{{crate_name}}:test" = {
      exec = "cargo test";
      execIfModified = [ "src/**/*.rs" "tests/**/*.rs" ];
    };

    "{{crate_name}}:run" = {
      exec = "cargo run";
      before = [ "{{crate_name}}:build" ];
    };

  };
  enterTest = ''
    cargo test
  '';

  git-hooks.hooks = {
    clippy.enable = true;
    clippy.settings.denyWarnings = true;
  };
}
