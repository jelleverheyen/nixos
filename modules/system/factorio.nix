{ pkgs, ... }:
{
  services.factorio = {
    enable = true;
    openFirewall = true; # UDP 34197
    saveName = "best-buds";
    game-name = "best-buds";
    public = false; # not listed on the public server browser
    lan = false;
    requireUserVerification = true; # players must have a valid factorio.com account
    autosave-interval = 5; # minutes
    nonBlockingSaving = true;
    package = pkgs.unstable.factorio-headless;
    # allowedPlayers = [ "friend-username" ];
  };
}
