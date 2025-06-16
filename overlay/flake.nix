{
  description = "My package collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Add this missing input:
    rehash = {
      url = "github:coopco/rehash";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rehash, ... }@inputs:
    let
      systems = [ "x86_64-linux" ];
    in
    {
      packages = nixpkgs.lib.genAttrs systems (system: {
        rehash = rehash.packages.${system}.default;
      });
    };
}
