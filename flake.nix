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
          script1 = pkgs.runCommand "script1" {} ''
            mkdir -p $out/bin
            cp ${./scripts/script1.js} $out/bin/script1.js
          '';

          script2 = pkgs.runCommand "script2" {} ''
            mkdir -p $out/bin
            cp ${./scripts/script2.js} $out/bin/script2.js
          '';

          script1-wrapped = pkgs.writeShellScriptBin "script1" ''
            ${pkgs.bun}/bin/bun ${script1}/bin/script1.js
          '';

          script2-wrapped = pkgs.writeShellScriptBin "script2" ''
            ${pkgs.bun}/bin/bun ${script2}/bin/script2.js
          '';
        in
        {
          script1 = script1-wrapped;
          script2 = script2-wrapped;
          default = script1-wrapped;
        }
      );

      apps = forAllSystems (system: {
        script1 = {
          type = "app";
          program = "${self.packages.${system}.script1}/bin/script1";
        };
        script2 = {
          type = "app";
          program = "${self.packages.${system}.script2}/bin/script2";
        };
        default = self.apps.${system}.script1;
      });
    };
}
