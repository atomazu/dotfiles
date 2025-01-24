!/usr/bin/env bash

if [ "$EUID" -ne 0  ]; then
  echo "This script must be run with sudo. Trying to run with sudo..."
  exit $?
fi
  PROFILE="${1:-desktop}"

  echo "Upgrading and rebuilding ${PROFILE} configuration."

  cd ~/.nixos
  nix-collect-garbage --delete-older-than 3d
  nix flake update
  nixos-rebuild switch --update --flake ~/.#"${PROFILE}"

  echo "Finished upgrade of ${PROFILE}."
