# Sets the brightness of all DDC/CI monitors.
#   brightness 50    set to an absolute value (0-100)
#   brightness +10   raise by 10
#   brightness -10   lower by 10
{ pkgs, ... }:
let
  brightness = pkgs.writeShellApplication {
    name = "brightness";
    runtimeInputs = [ pkgs.ddcutil ];
    text = ''
      value=''${1:-}
      if [[ ! $value =~ ^[+-]?[0-9]{1,3}$ ]]; then
        echo "Usage: brightness <0-100 | +N | -N>" >&2
        exit 1
      fi

      # Bus numbers change between boots, so detect on every run (~0.4s).
      mapfile -t buses < <(ddcutil --brief detect | sed -n 's|.*/dev/i2c-||p')
      if [[ ''${#buses[@]} -eq 0 ]]; then
        echo "No monitors found. Is i2c-dev loaded and are you in the i2c group?" >&2
        exit 1
      fi

      args=("$value")
      # ddcutil takes relative changes as separate tokens: "+ 10"
      [[ $value =~ ^[+-] ]] && args=("''${value:0:1}" "''${value:1}")

      for bus in "''${buses[@]}"; do
        ddcutil --bus "$bus" --noverify setvcp 10 "''${args[@]}" &
      done
      wait
    '';
  };
in
{
  home.packages = [ brightness ];
}
