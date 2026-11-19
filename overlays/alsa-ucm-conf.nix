final: prev: {
  alsa-ucm-conf = prev.alsa-ucm-conf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      echo "Patching Focusrite Scarlett 2i UCM profile"

      install -Dm644 \
        ${../modules/system/audio/Scarlett-2i.conf} \
        $out/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-2i.conf
    '';
  });
}
