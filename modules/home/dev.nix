{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Lua
    lua-language-server

    # NixOS
    nixd # LSP
    nixfmt-rfc-style # Formatter

    dotnet-sdk_9

    dbeaver-bin

    claude-code
  ];
}
