{ ... }:
{
  config.programs.git = {
    enable = true;
    userName = "tvo";
    userEmail = "tvo.email@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
