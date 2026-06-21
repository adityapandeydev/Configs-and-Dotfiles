# NixOS Flake Configuration

This branch contains the declarative NixOS Flake configuration mapping to my Arch Linux setup.

## Installation
1. Boot into a NixOS live environment.
2. Clone this repository and checkout the `nixos` branch.
3. Replace `hosts/default/hardware-configuration.nix` with the one generated for your specific machine (`nixos-generate-config --show-hardware-config > hosts/default/hardware-configuration.nix`).
4. Run `sudo nixos-install --flake .#nixos`
5. Reboot and enjoy.
