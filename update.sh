#!/usr/bin/env bash
git pull
nix flake update ~/nixos-config
bash ~/nixos-config/rebuild.sh
