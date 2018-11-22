This repository contains the NixOS configuration I use across several systems.

Modularity allows for easy use on a variety of platforms (laptop, desktop, VM, VPS, etc.) with a variety of use cases.
New systems are configured by creating a new `[device-name].nix` file (under `/devices`) and soft-linking `configuration.nix` to it.

This configuration is a perpetual work in progress.

### To-Do:
- [ ] Switch from default NixOS firewall to nftables
- [ ] Implement declarative file synchronization
- [ ] Implement wireguard vpn configuration
- [ ] Integrate YubiKey to ssh / luks (physical access systems)
