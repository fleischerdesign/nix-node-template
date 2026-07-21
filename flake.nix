{
  description = "A reproducible Node.js development environment with modern tooling.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    {
      templates.default = {
        path = ./.;
        description = "A reproducible Node.js development environment with modern tooling";
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodejs_22
            pkgs.yarn
            pkgs.nodePackages.typescript
            pkgs.nodePackages.prettier
            pkgs.nodePackages.eslint
          ];

          shellHook = ''
            echo "Entering Node.js development environment with Node.js ${pkgs.nodejs_22.version} and yarn."
          '';
        };
      });
}