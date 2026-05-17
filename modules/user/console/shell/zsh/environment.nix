{ config, ... }:
{
  config.programs.zsh.envExtra = ''
    export LANG="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export TERM="xterm-256color"

    export CARGO_HOME="${config.xdg.dataHome}/cargo"
    export NUGET_PACKAGES="${config.xdg.dataHome}/nuget"
    export LEIN_HOME="${config.xdg.dataHome}/lein"
    export PATH="$PATH:$HOME/.local/bin"

    # Python
    export PYTHONSTARTUP="${config.xdg.configHome}/python/pythonrc"
    export PYTHON_HISTORY="${config.xdg.stateHome}/python/history"  # Applied in python 3.13
    export PYTHONPYCACHEPREFIX="${config.xdg.cacheHome}/python"
    export PYTHONUSERBASE="${config.xdg.dataHome}/python"
    export JUPYTER_CONFIG_DIR="${config.xdg.configHome}/jupyter"
    export JUPYTER_PLATFORM_DIRS="1"

    # Mathematica
    export MATHEMATICA_USERBASE="${config.xdg.configHome}/mathematica"

    # IDL
    . "${config.home.homeDirectory}/04_applications/idl/9.1.0/idl/bin/idl_setup.bash"
    export SPEDAS_DATA_DIR="${config.xdg.dataHome}/spedas"
    export ROOT_DATA_DIR="${config.xdg.dataHome}/spedas"
    export IDL_PATH="<IDL_DEFAULT>:+${config.home.homeDirectory}/04_applications/spedas/bleeding_edge"
    export IDL_PATH="$IDL_PATH:+${config.home.homeDirectory}/Workspace/projects/_tvolib/tvolib/src/idl"

    # CDF
    export PATH="$PATH:$HOME/04_applications/cdf/3.9/bin"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/04_applications/cdf/3.9/lib"
  '';
}
