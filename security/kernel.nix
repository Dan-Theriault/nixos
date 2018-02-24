{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    linux_hardened_copperhead = pkgs.linux_hardened.override {
      # IA32_EMULATION is required by steam,
      # and is disabled by default in the hardened kernel
      extraConfig = ''
        IA32_EMULATION y 
      '';
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened_copperhead;
    kernel.sysctl = {
      "kernel.dmesg_restrict" = true;
      # "kernel.kptr_restrict" = 2;
      "kernel.unprivileged_bpf_disabled" = true;
      "net.core.bpf_jit_enable" = pkgs.lib.mkDefault false;
      "net.core.bpf_jit_harden" = true;
      "kernel.yama.ptrace_scope" = 1;
    };
  };
}
