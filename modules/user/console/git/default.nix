{ ... }:
{
  config.programs.git = {
    enable = true;
    userName = "tvo";
    userEmail = "tvo.work@proton.me";
    extraConfig.init = {
      defaultBranch = "main";
    };
  };
}
