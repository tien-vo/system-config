{ ... }:
{
    config.programs.git = {
        enable = true;
        settings = {
            init.defaultBranch = "main";
            pull.rebase = true;
            user = {
                name = "tien-vo";
                email = "work@tienvo.me";
            };
        };
    };
}
