{ config, ... }:
{
  config.programs.zsh.envExtra = ''
    export LANG="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"

    export CARGO_HOME="${config.xdg.dataHome}/cargo"
    export GNUPGHOME="${config.xdg.dataHome}/gnupg"
    export NUGET_PACKAGES="${config.xdg.dataHome}/nuget"
    export PYTHONSTARTUP="${config.xdg.configHome}/python/pythonrc"
    export PYTHON_HISTORY="${config.xdg.stateHome}/python/history"  # Applied in python 3.13
    export PYTHONPYCACHEPREFIX="${config.xdg.cacheHome}/python"
    export PYTHONUSERBASE="${config.xdg.dataHome}/python"
    export MATHEMATICA_USERBASE="${config.xdg.configHome}/mathematica"
    export JUPYTER_CONFIG_DIR="${config.xdg.configHome}/jupyter"
    export JUPYTER_PLATFORM_DIRS="1"
    export LEIN_HOME="${config.xdg.dataHome}/lein"
  '';
}
