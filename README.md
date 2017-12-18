This repository contains the NixOS configuration I use across several systems.

Modularity allows for easy use on a variety of platforms (laptop, desktop, VM, VPS, etc.) with a variety of use cases.
New systems are configured by creating a new [device-name].nix file (under "devices") and pointing configuration.nix at it.

This configuration is very much a work in progress (See To-Do, below).

### To-Do:
- [ ] Switch from default NixOS firewall to nftables
- [ ] Implement declarative file synchronization
- [ ] Implement wireguard vpn configuration
- [ ] Integrate YubiKey to ssh / luks (physical access systems)
- [ ] Rice. Rice everywhere.
