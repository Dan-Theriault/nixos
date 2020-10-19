{ pkgs, emacsPkg ? pkgs.emacs, ...}:

let
  emacsWithPackages = (pkgs.emacsPackagesNgGen emacsPkg).emacsWithPackages;
  myEmacs = emacsWithPackages ( epkgs:
    (with epkgs.elpaPackages; [
      aggressive-indent
      auctex
      delight
      undo-tree
    ]) ++ (with epkgs.melpaPackages; [
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
      evil-goggles
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
      pdf-tools
      poet-theme
      proof-general
      s
      slime
      srefactor
      typo
      use-package

      amx
      auctex-latexmk
      # company-auctex
      company-coq
      # company-lsp
      company-quickhelp
      company-shell
      diff-hl
      # hlint-refactor intero
      json-mode
      latex-extra
      magic-latex-buffer
      swiper
      use-package
      ws-butler
    ]) ++ (with epkgs.orgPackages; [
      org
      org-plus-contrib
    ]));
in
  # myEmacs
  emacsPkg
