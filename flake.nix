{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # latest.url = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:srid/nix-doom-emacs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-wayland.inputs.master.follows = "master";

    # sops-nix
    # mozilla overlay ?
    # neovim overlay ?
    # apparmor-nix ?

    vim-dim.url = "github:jeffkreeftmeijer/vim-dim";
    vim-dim.flake = false;

    # devOS-style custom packages
    # pkgs.url = "path:./pkgs";
    # pkgs.inputs.nixpkgs.follows = "nixos";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      mkMachine = configurationNix: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit system inputs; };
        modules = [
          configurationNix
          ./base.nix                   
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dan = import ./home.nix {
              inherit inputs system;
              pkgs = import nixpkgs { inherit system; };
            };
          }
        ] ++ extraModules;
      };
    in
    {
      nixosConfigurations.geist = mkMachine 
        ./devices/geist.nix 
        [ ( { config, pkgs, ...}: 
          {
            nixpkgs.overlays = [
              inputs.nixpkgs-wayland.overlay
              inputs.emacs-overlay.overlay
              # inputs.neovim-nightly-overlay.overlay
            ];

            environment.systemPackages = (import ./desktop/pkgs.nix {
              inherit pkgs;
              tex = true;
            }) ++ (with pkgs; [
              mullvad-vpn
              solaar # TODO: package logiops
              grim
              imv
              slurp
              wf-recorder
              wl-clipboard
            ]);
            
            boot.loader.systemd-boot = {
              enable = true;
              editor = false;
            };
            boot.loader.efi.canTouchEfiVariables = true;

            networking.hostName = "geist"; 

            # emacs service
            services.emacs = {
              enable = true;
              # defaultEditor = true;
              package = pkgs.emacsPgtkGcc;
            };

            services.pipewire.enable = true;

            xdg.portal = {
              enable = true;
              extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
              gtkUsePortal = true; # causes issues with hidpi
            };

            # system.autoUpgrade = {
            #   enable = true;
            #   dates = "02:30";
            # };

            # systemd.services.nixos-upgrade.path = with pkgs; [
            #   gnutar xz.bin gzip config.nix.package.out
            # ];

            hardware.bluetooth.enable = false;

            # hardware.logitech.wireless = {
            #   enable = true;
            #   enableGraphical = true;
            # };

            # services.xserver.videoDrivers = [ "amdgpu" ];
            services.xserver.videoDrivers = [ "virtio-vga" ];
            services.qemuGuest.enable = true;
            services.spice-vdagentd.enable = true;
            powerManagement.cpuFreqGovernor = "performance";

            hardware.opengl.enable = true;
            hardware.opengl.extraPackages = with pkgs; [ ];

            console.font = "sun12x22";

            # networking.iproute2.enable = true; #required for mullvad
            # services.mullvad-vpn.enable = true;
          })
          "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"

          ./desktop
          # ../desktop/audio.nix
          ./desktop/fonts.nix
          # ../desktop/gaming.nix

          ./developer

          ./net
          # ../net/ssh-client.nix 
          # ../net/ssh-server.nix

          # ../security
        ];
    };
}
