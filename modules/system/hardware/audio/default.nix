{ ... }:
{
  config.security.rtkit.enable = true;
  config.services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
