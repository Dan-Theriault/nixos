{ config, pkgs, ... }:

{
  services.haveged.enable = true; # better entropy generation
  networking.tcpcrypt.enable = true; # opportunistic TCP encryption. 
  nix.allowedUsers = [ "@wheel" "@builders" ];

  security = {
    apparmor.enable = true;
  };

  environment.systemPackages = with pkgs; [ vulnix ];

  # nixpkgs.config.packageOverrides = pkgs: {
  #   linux_latest_hardened = pkgs.linux_latest_hardened.override {
  #     extraConfig = ''
  #       IA32_EMULATION y
        
  #       DM_CRYPT m
  #       DM_SNAPSHOT m
  #       DM_MIRROR m
  #       DM_LOG_USERSPACE m
  #       DM_ZERO m
  #       DM_MULTIPATH m
  #       DM_MULTIPATH_QL m
  #       DM_MULTIPATH_ST m
  #       DM_DELAY m
  #       DM_UVENT y

  #       SND_USB_AUDIO m
  #       SND_HDA_CODEC_GENERIC y
  #       SND_HDA_CODEC_HDMI m
  #       SND_HDA_CODEC_INTEL y

  #       BRIDGE y
  #       BRIDGE_NETFILTER y
  #       BRIDGE_IGMP_SNOOPING y
  #       IP6_NF_MATCH_RPFILTER m
  #       IP6_NF_RAW m
  #       IP_ADVANCED_ROUTER y
  #       IP_MULTIPLE_TABLES y
  #       IP_NF_MATCH_RPFILTER m
  #       IP_NF_RAW m
  #       NETFILTER_NETLINK y
  #       NETFILTER_NETLINK_LOG y
  #       NETFILTER_NETLINK_QUEUE y
  #       NETFILTER_XT_MATCH_PKTTYPE m
  #       NETFILTER_XT_TARGET_CHECKSUM m
  #       NETFILTER_XT_TARGET_MARK m
  #       NETFILTER_XT_TARGET_NFQUEUE m
  #       NET_SCHED y
  #       NET_SCH_INGRESS y
  #       NF_CONNTRACK_TIMESTAMP y
  #       NF_CT_NETLINK m
  #       NF_NAT_IPV6 y
  #       SCSI_NETLINK y
  #       TUN y

  #       KVM m
  #       KVM_INTEL m

  #       USB_EHCI_TT_NEWSCHED y

  #       HID_LOGITECH_DJ y
  #       HID_LOGITECH_HIDPP y

  #       FUSE_FS m
  #       SQUASHFS m
  #       OVERLAY_FS m
  #     '';
  #     features.ia32Emulation = true;
  #     autoModules = false;
  #     ignoreConfigErrors = true;
  #     kernelPreferBuiltin = true;
  #     enableParallelBuilding = true;
  #   };
  # };
  
  # boot = {
  #   kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest_hardened;
  #   kernel.sysctl = {
  #     "kernel.dmesg_restrict" = true;
  #     # "kernel.kptr_restrict" = 2;
  #     "kernel.unprivileged_bpf_disabled" = true;
  #     "net.core.bpf_jit_enable" = pkgs.lib.mkDefault false;
  #     "net.core.bpf_jit_harden" = true;
  #     "kernel.yama.ptrace_scope" = 1;
  #     "kernel.unprivileged_userns_clone" = 1; # required for steam
  #   };
  #   initrd.kernelModules = [ "dm-crypt" ]; 
  # };
}
