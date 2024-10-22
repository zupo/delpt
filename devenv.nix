{ pkgs, config, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; config.allowUnfree = true;  };
in
{

  languages.elm.enable = true;

  packages = [
    pkgs.which
    pkgs.git
    pkgs-unstable.elmPackages.lamdera
    pkgs.elmPackages.elm-land
    pkgs-unstable.elmPackages.elm-test-rs
    pkgs.nodejs
    pkgs.tailwindcss
  ];

  pre-commit.hooks = {
    actionlint.enable = true;
    check-added-large-files.enable = true;
    check-case-conflicts.enable = true;
    check-executables-have-shebangs.enable = true;
    check-merge-conflicts.enable = true;
    check-shebang-scripts-are-executable.enable = true;
    check-yaml.enable = true;
    typos.enable = true;
    deadnix.enable = true;
    detect-private-keys.enable = true;
    ripsecrets.enable = true;

    trim-trailing-whitespace.enable = true;
    trim-trailing-whitespace.excludes = [".elm-land/"];

    end-of-file-fixer.enable = true;
    end-of-file-fixer.excludes = [".elm-land/"];

    shellcheck.enable = true;
    shellcheck.excludes = [".yml" ".yaml"];

    denofmt.enable = true;
    denofmt.excludes = ["elm.json" "review/elm.json" "elm-land.json" ".elm-land/"];

    elm-format.enable = true;
    elm-format.excludes = [".elm-land/" "src/Evergreen"];

    elm-review.enable = true;
    elm-review.excludes = [".elm-land/"];
  };

  enterShell = ''
    lamdera make src/Env.elm
  '';

  enterTest = ''
    elm-test-rs --compiler $(which lamdera)
  '';


  processes =
    if !config.devenv.isTesting
    then
      {
        elm-land.exec = "elm-land server";
        lamdera.exec = "lamdera live";
        tailwind.exec = "tailwindcss -i ./src/style.css -o ./public/style.css --watch";
      }
    else {};

  scripts.lint.exec = "pre-commit run --all-files";
  scripts.test.exec = "elm-test-rs --compiler $(which lamdera)";
}
