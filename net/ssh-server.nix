{config, pkgs, ...}:

{
  services.openssh = {
    enable = true;
    hostKeys = [
      { bits = 4096; path = "/etc/ssh/ssh_host_rsa_key"; type = "rsa";  }
      { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
    ] ;
    permitRootLogin = "no";
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    extraConfig = ''
      KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      Protocol 2
      PubkeyAuthentication yes
      AllowGroups ssh-user
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
    '';
  };

  users.users.dtheriault3 = {
    openssh.authorizedKeys.keyFiles = [
      /etc/ssh/ssh_host_ed25519_key
      /etc/ssh/ssh_host_rsa_key
    ];
    extraGroups = [ "ssh-user" ];
  };
  users.groups = { ssh-user = { }; };

  services.tor = {
    enable = true;
    hiddenServices."ssh" = { # find .onion address in file /var/lib/tor/onion/<name>
      map = [ { port = 22; toPort = 22; } ];
    };
  };
}
