#!/usr/bin/env bash
# shellcheck disable=1090
set -e

(( EUID != 0 )) && SUDO=sudo || SUDO=

if [[ "$1" = 'remove' ]] ; then
  $SUDO rm -rf ~/.nix-profile*
  $SUDO rm -rf /nix /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf \
               ~/.cache/nix ~/.config/nix ~/.local/state/nix \
               ~/.nix-channels ~/.nix-defexpr ~/.cache/nix
  exit 0
fi

mkdir -p ~/.config/nix
echo 'experimental-features = flakes nix-command' > ~/.config/nix/nix.conf
# echo 'build-users-group =' >> ~/.config/nix/nix.conf
# echo 'sandbox = false' >> ~/.config/nix/nix.conf

# this is single-user, for multi-user disable SELinux and change to --daemon
curl --proto '=https' --tlsv1.2 -fsSL https://nixos.org/nix/install | sh -s -- --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh

_nix="$(readlink -f "$(which nix)")"
"$_nix" profile remove nix
"$_nix" profile add nixpkgs#nix
