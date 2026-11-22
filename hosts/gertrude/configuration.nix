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

  nixpkgs.overlays = [
    inputs.nix-claude-code.overlays.default
    # Exposes nixos-unstable packages as pkgs.unstable.<name>
    (final: _: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
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

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/2f156f5c-10da-48ea-b03d-061808c02f03";
    fsType = "ext4";
    # nofail: boot without it; x-gvfs-*: show in the file manager sidebar
    options = [
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=data"
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

  # Desktop environment: "gnome" or "hyprland"
  desktop.environment = "gnome";

  programs.cdemu.enable = true;

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
    direnv
    alsa-utils
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

  # Passkeys/FIDO2: grant the logged-in user access to security keys (hidraw)
  services.udev.packages = [ pkgs.libfido2 ];
  programs.yubikey-manager.enable = true;

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
