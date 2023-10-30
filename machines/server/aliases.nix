{ config, pkgs, ... }:
{
environment.interactiveShellInit = ''
  alias dimmich='docker-compose -f "/mnt/storage/appdata/immich/docker-compose.yml"'
  alias dhome='docker-compose -f "/mnt/storage/appdata/homeassistant/compose.yaml"'
  alias dservice='docker-compose -f "/mnt/storage/appdata/services/compose.yml"'
  alias dmedia='docker-compose -f "/mnt/storage/appdata/media/compose.yaml"'
  alias dmatrix='docker-compose -f "/mnt/storage/appdata/matrix/docker-compose.yml"'
  alias dpaper='docker-compose -f "/mnt/storage/appdata/paperless/compose.yaml"'
  alias drss='docker-compose -f "/mnt/storage/appdata/rss/compose.yml"'
  alias dedit='nvim /mnt/storage/appdata/'

  alias nixosedit='nvim /etc/nixos/'
  '';
  }
