{ pkgs, ... }:
{
  config.services.gnome.gnome-keyring.enable = true;
  config.systemd.user.services.protonmail-bridge = {
    enable = true;
    description = "ProtonMail Bridge";
    script = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --non-interactive --log-level info";
    path = [ pkgs.gnome3.gnome-keyring ];
    wantedBy = [ "graphical-session.target" ];          
    partOf = [ "graphical-session.target" ];
  };
}
