{ config, pkgs, ... }:
{
  config.programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    history = {
      extended = true;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    antidote = {
      enable = true;
      plugins = [ "romkatv/powerlevel10k" ];
    };
    initExtra = ''
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

      bindkey -v
      bindkey "^ " autosuggest-accept
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -h --icons=auto --sort=name --group-directories-first";
      tree = "${pkgs.eza}/bin/eza --color=auto --tree";
    };
  };

  config.home.packages = [
    pkgs.eza
  ];
}
