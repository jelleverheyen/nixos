{ pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  imports = [
    ./hardware-configuration.nix
  ];

  systemd.user.services.pipewire.environment = {
    ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";
  };

  systemd.user.services.wireplumber.environment = {
    ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";
  };

  systemd.user.services.cdemu-daemon = {
    description = "CDEmu Daemon";
    serviceConfig = {
      ExecStart = "${pkgs.cdemu-daemon}/bin/cdemu-daemon";
      Restart = "on-failure";
    };
  };

  nixpkgs.overlays = [
    inputs.nix-claude-code.overlays.default
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    extraModulePackages = [
      pkgs.linuxPackages.vhba
    ];

    kernelModules = [
      "i2c-dev" # Access i2c devices from userspace (for ddcutil monitors)
      "coretemp"
      "cpuid"
      "vhba"
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
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
    cdemu-daemon
    cdemu-client
    gcdemu
  ];

  users.groups.i2c = { };

  users.users.jelle = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Jelle Verheyen";
    extraGroups = [
      "cdrom"
      "networkmanager"
      "wheel"
      "minecraft"
      "i2c"
    ];
  };

  services.dbus.packages = [ pkgs.cdemu-daemon ];

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    KERNEL=="vhba_ctl", MODE="0660", GROUP="cdrom"
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
