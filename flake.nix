{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";

    openapi3 = { url = "github:topagentnetwork/openapi3"; flake = false; };
    servant-openapi3 = { url = "github:topagentnetwork/servant-openapi3"; flake = false; };
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      imports = [ inputs.haskell-flake.flakeModule ];
      perSystem = { self', pkgs, config, ... }:
        {
          haskellProjects.default = {
            packages = {
              openapi3.source = inputs.openapi3;
              servant-openapi3.source = inputs.servant-openapi3;
            };
            settings = {
              hspec = { super, ... }: {
                custom = _: super.hspec_2_11_7;
              };
              hspec-api = {
                broken = false;
              };
              http-api-data = { super, ... }: {
                custom = _: super.http-api-data_0_6;
              };
              hspec-core = { super, ... }: {
                custom = _: super.hspec-core_2_11_7;
              };
              openapi3 = { check = false; };
              servant-openapi3 = { check = false; jailbreak = true; };
              tasty-hspec = { super, ... }: {
                custom = _: super.tasty-hspec_1_2_0_4;
              };
            };
          };
        };
    };
}
