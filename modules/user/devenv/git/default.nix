{ ... }:
{
    config.programs.git = {
        enable = true;
        userName = "tien-vo";
        userEmail = "tvo.email@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
            pull.rebase = true;
        };
    };
}
