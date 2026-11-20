# Settings shared by all desktop environments.
{
  services.displayManager.autoLogin = {
    enable = true;
    user = "jelle";
  };

  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";
  };
}
