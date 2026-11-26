# Duochrome, on the fleet's shared repo shape (github:ismailkattakath/repo-kit).
#
#   nix develop           → git
#   nix fmt               → treefmt (nixfmt; *.css and *.md are left byte-for-byte as written)
#   nix flake check       → treefmt + toolchain-complete + the generated-file drift checks
#                           + version-header (line 1 of duochrome.css names CHANGELOG's top version)
#   nix run .#write-files → regenerate .envrc, .editorconfig, devcontainer.json
#
# No CSS/Markdown formatter on purpose: consumers vendor duochrome.css byte-exact and pin its
# sha256 (kattakath/ismail-landing's `design-system` CI job), so a reflow would read as a release.
{
  description = "Duochrome, a two-value design system: pure black ink on pure white ground, Roboto type, nothing in between.";

  inputs = {
    repo-kit.url = "github:ismailkattakath/repo-kit";
    # One nixpkgs and one flake-parts for the whole fleet: follow the kit's.
    nixpkgs.follows = "repo-kit/nixpkgs";
    flake-parts.follows = "repo-kit/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, repo-kit, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ repo-kit.flakeModules.default ];

      repoKit = {
        name = "design-system";
        license = {
          # null: keep the hand-wrapped MIT LICENSE as committed (same text and holder as
          # ismailkattakath/website) instead of the kit's re-wrapped copy. year/holder stay
          # set because the options require them.
          spdx = null;
          year = "2026";
          holder = "Ismail Kattakath";
        };
      };

      perSystem =
        { lib, pkgs, ... }:
        {
          repoKit = {
            devPackages = [ pkgs.git ];
            requiredBins = [ "git" ];
          };

          # The version a consumer's pin checks (`head -n 1 | grep "Duochrome design system,
          # v<ver>"`) must be the release CHANGELOG.md documents last.
          checks.version-header =
            let
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./duochrome.css
                  ./CHANGELOG.md
                ];
              };
            in
            pkgs.runCommandLocal "version-header" { } ''
              css=$(head -n 1 ${src}/duochrome.css | sed -n 's/.*Duochrome design system, v\([0-9][0-9.]*\)$/\1/p')
              log=$(sed -n 's/^## \([0-9][0-9.]*\) .*/\1/p' ${src}/CHANGELOG.md | head -n 1)
              if [ -z "$css" ] || [ "$css" != "$log" ]; then
                echo "duochrome.css line 1 names v''${css:-?}; CHANGELOG.md's top release is ''${log:-?}" >&2
                exit 1
              fi
              touch "$out"
            '';
        };
    };
}
