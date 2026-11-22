{ pkgs, ... }:

# Pinchflat downloads YouTube channels and playlists into the videos folder,
# laid out for Plex or Jellyfin. pinchflat-ngx is the maintained fork. The
# homelab daemon's host module gives the media group the folder's gid and
# opens the route's port.
{
  users.groups.media = { };

  services.pinchflat = {
    enable = true;
    package = pkgs.pinchflat-ngx;
    mediaDir = "/pool/media/youtube";
    port = 8945;
    logLevel = "info";
    group = "media";
    # Behind Caddy on a private network: no login of its own.
    selfhosted = true;
  };
  # Files and folders it makes stay writable for the media group.
  systemd.services.pinchflat.serviceConfig.UMask = "0002";
}
