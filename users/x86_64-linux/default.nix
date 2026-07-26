{ args, home-names, inputs, pkgs }:
let
  mk-home = home-name:
    let
      match = builtins.match "([^@]+)@([^@]+)" home-name;

      identity =
        if match == null then
          throw ''
            Invalid Home Manager configuration name: ${home-name}

            Expected the form:

              user@machine
          ''
        else
          {
            user-name = builtins.elemAt match 0;
            machine-name = builtins.elemAt match 1;
          };

      home-module = ./${home-name};
      home-module-file = ./${home-name}/default.nix;
    in
    if !builtins.pathExists home-module-file then
      throw ''
        Selected Home Manager configuration does not exist:

          ${home-module-file}
      ''
    else
      {
        name = home-name;

        value = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            inputs.sops-nix.homeManagerModules.sops
            home-module
          ];

          extraSpecialArgs = args // {
            inherit (identity) user-name machine-name;
          };
        };
      };
in
builtins.listToAttrs (
  map mk-home home-names
)
