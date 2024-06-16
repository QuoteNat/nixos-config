#!/usr/bin/env bash
git pull
nix flake update ~/nixos-config
sudo nixos-rebuild switch --flake ~/nixos-config
