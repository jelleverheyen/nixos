{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    # Patch Scarlett Solo 4
    (import ../../overlays/alsa-ucm-conf.nix)

    # Force Python 3.12 because Python 3.13 is feral
    (final: prev: {
      python3 = prev.python312;
      python3Packages = prev.python312Packages;
    })
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

  services.hypridle.enable = true;

  services.printing.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    direnv
    alsa-utils
  ];

  users.groups.i2c = { };

  users.users.jelle = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Jelle Verheyen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "minecraft"
      "i2c"
    ];
  };

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
    "electron-36.9.5"
  ];

  system.stateVersion = "24.05";
}
