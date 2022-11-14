{
  description = "A flake that sets up the devShell and vscode";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let supportedSystems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ]; in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        vscode-overlay = final: prev: {
          vscodium = prev.vscodium.overrideAttrs (old: {
            buildInputs = old.buildInputs or [ ] ++ [ final.makeWrapper ];
            postFixup = old.postFixup or "" + ''
              wrapProgram $out/bin/${pkgs.vscodium.executableName} \
                --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
            '';
          });
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ vscode-overlay ];
        };
        vscode-with-extensions = pkgs.vscode-with-extensions.override {
          vscode = pkgs.vscodium;
          vscodeExtensions = [
          ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            vscode-with-extensions
          ];
        };
      });
}
