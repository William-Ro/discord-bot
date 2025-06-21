{
  description = "Dev Shell for Python Development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    pythonEnv = pkgs.python312.withPackages (ps: with ps; [pip]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pythonEnv
        pkgs.virtualenv
      ];

      shellHook = ''
        echo "Welcome to the Python Development Shell"
      '';
    };
  };
}
