{
  description = "JavaScript scripts using Bun runtime";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # Copy scripts to the store
          readable = pkgs.runCommand "readable" {} ''
            mkdir -p $out/bin
            cp ${./scripts/readable.js} $out/bin/readable.js
          '';

          script2 = pkgs.runCommand "script2" {} ''
            mkdir -p $out/bin
            cp ${./scripts/script2.js} $out/bin/script2.js
          '';

          readable-wrapped = pkgs.writeShellScriptBin "readable" ''
            ${pkgs.bun}/bin/bun ${readable}/bin/readable.js
          '';

          script2-wrapped = pkgs.writeShellScriptBin "script2" ''
            ${pkgs.bun}/bin/bun ${script2}/bin/script2.js
          '';
        in
        {
          readable = readable-wrapped;
          script2 = script2-wrapped;
          default = readable-wrapped;
        }
      );

      apps = forAllSystems (system: {
        readble = {
          type = "app";
          program = "${self.packages.${system}.readble}/bin/readable";
        };
        script2 = {
          type = "app";
          program = "${self.packages.${system}.script2}/bin/script2";
        };
        default = self.apps.${system}.readable;
      });
    };
}
