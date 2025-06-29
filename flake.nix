{
  description = "Dev Shell for Python Development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-darwin"];
    forEachSystem = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        supportedSystems);
  in {
    devShells = forEachSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.python312
          pkgs.virtualenv
          pkgs.alejandra
        ];

        shellHook = ''
          echo "Welcome to Python Dev Shell on ${system}"
        '';
      };
    });
  };
}
