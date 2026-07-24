{ config, pkgs, ... }:
{
  config.programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      extended = true;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    autosuggestion.enable = true;
    oh-my-zsh.enable = true;
    antidote = {
      enable = true;
      plugins = [ "romkatv/powerlevel10k" ];
    };
    initContent = ''
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

      bindkey -v
      bindkey "^ " autosuggest-accept
      bindkey '^P' up-line-or-search
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -h --icons=auto --sort=name --group-directories-first";
      tree = "${pkgs.eza}/bin/eza --color=auto --tree";
      virt-manager = "${config.home.homeDirectory}/.local/bin/virt-manager";
    };
  };

  imports = [
    ./environment.nix
  ];
}
