{ config, pkgs, ... }:

{
  services.haveged.enable = true; # better entropy generation
  networking.tcpcrypt.enable = true; # opportunistic TCP encryption. 
  nix.allowedUsers = [ "@wheel" "@builders" ];

  security = {
    apparmor.enable = true;
  };

  environment.systemPackages = with pkgs; [ vulnix ];

  nixpkgs.config.packageOverrides = pkgs: {
    linux_latest_hardened = pkgs.linux_latest_hardened.override {
      extraConfig = ''
        IA32_EMULATION y
        
        DM_CRYPT m
        DM_SNAPSHOT m
        DM_MIRROR m
        DM_LOG_USERSPACE m
        DM_ZERO m
        DM_MULTIPATH m
        DM_MULTIPATH_QL m
        DM_MULTIPATH_ST m
        DM_DELAY m
        DM_UVENT y

        SND_USB_AUDIO m
        SND_HDA_CODEC_GENERIC y
        SND_HDA_CODEC_HDMI m
        SND_HDA_CODEC_INTEL y

        IP_NF_RAW m
        IP6_NF_RAW m
        NETFILTER_NETLINK m
        NETFILTER_NETLINK_QUEUE m
        NETFILTER_XT_TARGET_NFQUEUE m
        NF_NAT_IPV6 m
        IP_NF_MATCH_RPFILTER m
        IP6_NF_MATCH_RPFILTER m
        NETFILTER_XT_MATCH_PKTTYPE m
        NETFILTER_XT_TARGET_CHECKSUM m
        NF_CONNTRACK_TIMESTAMP y

        KVM m
        KVM_INTEL m

        USB_EHCI_TT_NEWSCHED y

        HID_LOGITECH_DJ y
        HID_LOGITECH_HIDPP y
      '';
      features.ia32Emulation = true;
      autoModules = false;
      ignoreConfigErrors = true;
      kernelPreferBuiltin = true;
      enableParallelBuilding = true;
    };
  };
  
  boot = {
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest_hardened;
    kernel.sysctl = {
      "kernel.dmesg_restrict" = true;
      # "kernel.kptr_restrict" = 2;
      "kernel.unprivileged_bpf_disabled" = true;
      "net.core.bpf_jit_enable" = pkgs.lib.mkDefault false;
      "net.core.bpf_jit_harden" = true;
      "kernel.yama.ptrace_scope" = 1;
      "kernel.unprivileged_userns_clone" = 1; # required for steam
    };
    initrd.kernelModules = [ "dm-crypt" ]; 
  };
}
