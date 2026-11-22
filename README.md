# stack-pinchflat

[Pinchflat](https://github.com/kieraneglin/pinchflat) downloads YouTube
channels and playlists into a folder that Plex or Jellyfin can show. This
stack for [homelab-ngx](https://github.com/homelab-ngx/homelab-ngx) runs
[pinchflat-ngx](https://github.com/TheBadFella/Pinchflat-NGX), a fork of it,
built from nixpkgs.

## Getting started

1. Add the stack: `homelab stacks add github:homelab-ngx/stack-pinchflat`,
   or Add stack on the dashboard's Stacks page.
2. On the stack's page, set `YOUTUBE_DIR` to the folder for the videos.
   Pinchflat writes through the folder's group, so the group needs write
   access.
3. Approve the grants and start the stack.
4. Open `https://pinchflat.<your domain>`, make a media profile and add
   sources.

Pinchflat has no login of its own. Its route is served only on your private
network.

The backup folder below holds Pinchflat's settings and database. The videos
are not among them: add `YOUTUBE_DIR` to a backup yourself.

<!-- manifest:start -->
<!-- Made from homelab-stack.json. Change the manifest, not these lines. -->

## Grants

You approve each of these before the stack starts.

- Route: `pinchflat.<your domain>` to port 8945 in the stack.
- Storage: the folder in `YOUTUBE_DIR`, at `/pool/media/youtube` in the stack, read-write.

## Variables

| Name | Kind | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `YOUTUBE_DIR` | path | yes |  | Where Pinchflat saves the videos it downloads. Its group becomes the stack's media group, which Pinchflat writes as. |

## Backup

The stack recommends these folders. None is backed up until you add it to a backup.

- Pinchflat settings: `/var/lib/pinchflat` in the stack.
  - Without `/tmp/**`. Downloads in progress.
  - Without `/logs/**`. Log files.
  - Without `/metadata/**`. Video thumbnails and descriptions. Pinchflat downloads them again.

## Health

An update is kept when all of this holds, and rolled back when it does not.

- `pinchflat.service` is active.
- Port 8945 answers at `/healthcheck`.

Manifest version 8, built with nixpkgs `nixos-unstable`. Runs on [homelab-ngx](https://github.com/homelab-ngx/homelab-ngx).

<!-- manifest:end -->

## License

MIT, see [LICENSE](LICENSE).
