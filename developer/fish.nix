{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./fish_prompt.fish;   
    
    shellAliases = {
      o = "xdg-open";
      ipy = "ipython3";
      sgit = "sudo -E git";
      lopdf = "libreoffice --writer --headless --convert-to pdf";
    };

    interactiveShellInit = ''
      function bind_bang
        switch (commandline -t)[-1]
          case "!"
            commandline -t $history[1]; commandline -f repaint
          case "*"
            commandline -i !
        end
      end

      function bind_dollar
        switch (commandline -t)[-1]
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
        end
      end

    function fish_user_key_bindings
      bind ! bind_bang
      bind '$' bind_dollar
      set -g fish_key_bindings fish_vi_key_bindings
      bind -M insert \ck kill-line
      bind -M insert \ca beginning-of-line
      bind -M insert \ce end-of-line
    end

    function fish_greeting
    end

    function fish_right_prompt
      if [ $IN_NIX_SHELL ]
        echo "[ $NIX_SHELL ]"
      end
    end
  '';
  };
}
