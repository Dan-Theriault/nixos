{ config, pkgs, ... }:

# Remember to create client keys
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [ mosh ];
  
  programs.ssh = {
    agentTimeout = "1h";

    extraConfig = ''
      # Github needs diffie-hellman-group-exchange-sha1 "some of the time but not always".
      Host github.com
          KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1

      Host *.onion
          ProxyCommand socat - SOCKS4A:localhost:%h:%p,socksport=9050

      Host *
          KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256

          Protocol 2
          PasswordAuthentication no
          ChallengeResponseAuthentication no

          PubkeyAuthentication yes
          HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa
          Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
          MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
          useRoaming no

          # Other
          SendEnv LANG LC_*
          HashKnownHosts yes
          # GSSAPIAuthentication yes
    '';
#   knownHosts = [ {
#     hostNames = [ "homestead" ( builtins.readFile /etc/nix-secrets/homestead-onion) ];
#     publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE90pn7PDUD40oL4wPGANNh4TsPuJPJE59Ss5r5+aOly";
#   } ];
  };

}
