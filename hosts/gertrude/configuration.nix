{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelModules = [
      "i2c-dev" # Access i2c devices from userspace (for ddcutil monitors)
      "coretemp"
      "cpuid"
    ];
  };

  networking = {
    hostName = "gertrude";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "jelle";

    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    direnv
  ];

  users.users.jelle = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Jelle Verheyen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "minecraft"
    ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
