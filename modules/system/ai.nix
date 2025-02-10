{ ... }:
{
  services.open-webui.enable = true;
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}
