#!/usr/bin/env bash
git pull
nix flake update ~/nixos-config
flatpak update -y --noninteractive # For any installed flatpaks
bash ~/nixos-config/rebuild.sh
