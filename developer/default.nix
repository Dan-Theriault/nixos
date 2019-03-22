{ config, pkgs, ... }:

let 
  emacsLucid = pkgs.emacs.overrideDerivation (old: {
    configureFlags = [ "--with-x-toolkit=lucid" ];
  });
  emacsWithPackages = (pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages;
  myEmacs = emacsWithPackages ( epkgs:
    (with epkgs.melpaPackages; [
      alert
      company
      company-nixos-options
      counsel
      dash
      deft
      elpy
      evil
      evil-cleverparens
      evil-collection
      evil-commentary
      evil-indent-textobject
      evil-leader
      evil-magit
      evil-org
      evil-surround
      exec-path-from-shell
      f
      find-file-in-project
      flycheck
      frames-only-mode
      geiser
      highlight-parentheses
      hl-todo
      ht
      ivy
      magit
      markdown-mode
      nix-mode
      nix-sandbox
      nixos-options
      olivetti
      org-journal
      poet-theme
      s
      slime
      srefactor
      typo
    ]) ++ (with epkgs.orgPackages; [
      org
      org-plus-contrib
    ]));
in
{
  imports = [
    ../developer/fish.nix
    ../developer/vim.nix
    # ../developer/android.nix
    ../developer/python.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops 
    # nixos-shell
    # pgmanage pgcli pg_top 
    arduino platformio
    fd ripgrep 
    # tokei 

    telnet netcat
    jq
    # postman
    jdk8

    shellcheck
    go
    sqlite

    myEmacs
    guile sbcl lispPackages.quicklisp
  ];

  # emacs service
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = myEmacs;
  };

  # virtualisation.libvirtd.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  # networking.firewall.checkReversePath = "loose";

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
