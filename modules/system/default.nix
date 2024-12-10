{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./minecraft.nix
    ./fish.nix
  ];

  hardware.opentabletdriver.enable = true;

  /*
    pkgs.writeShellApplication = {
      name = "brightness";
      runtimeInputs = [ pkgs.ddcutil ];

      text = ''
        if test (count $argv) -eq 0
              echo "Usage: brightness <level>"
              return 1
          end
          set level $argv[1]
          ddcutil setvcp 10 $level
      '';
    };
  */

}
