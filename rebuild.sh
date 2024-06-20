#!/usr/bin/env bash
git pull
nixos_old_gen=$(readlink -f /run/current-system)
sudo nixos-rebuild switch --flake ~/nixos-config
nixos_new_gen=$(readlink -f /run/current-system)
nvd diff "$nixos_old_gen" "$nixos_new_gen"
