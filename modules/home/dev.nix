{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Lua
    lua-language-server

    # NixOS
    nixd # LSP
    nixfmt-rfc-style # Formatter

    vscode

    dotnet-sdk_9

  ];
}
