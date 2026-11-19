{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Lua
    lua-language-server

    # NixOS
    nixd # LSP
    nixfmt # Formatter

    dotnet-sdk_9

    dbeaver-bin

    claude-code
  ];
}
