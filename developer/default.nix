{ config, pkgs, ... }:

{
  imports = [
    ../developer/android.nix
    ../developer/fish.nix
    ../developer/pkgs.nix
    ../developer/python.nix
    ../developer/vim.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops
    pgmanage pgcli pg_top
    arduino platformio
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  networking.firewall.checkReversePath = false;
  services.postgresql.enable = true;

  nix = { 
    package = pkgs.nixUnstable;

    # nixPath = [ 
    #   "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs" 
    #   "nixos-config=/etc/nixos/configuration.nix" 
    #   "/nix/var/nix/profiles/per-user/root/channels" 
    # ];
    # ++ [ 
    #   "ssh-config-file=/etc/static/deploy/ssh" "ssh-auth-sock=$SSH_AUTH_SOCK"
    # ];
  };

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
