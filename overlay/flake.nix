{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rehash.url = "path:/home/connor/Projects/rehash";
    #my-tool.url = "github:me/my-tool";
    #another-tool.url = "github:me/another-tool";
    # This file grows, but main flake.nix doesn't
  };

  outputs = { nixpkgs, ... }@inputs:
    nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: {
      packages.${system} = {
        rehash = inputs.rehash.packages.${system}.default;
        my-tool = inputs.my-tool.packages.${system}.default;
        another-tool = inputs.another-tool.packages.${system}.default;
      };
    });
}
