{ config, pkgs, ... }: 

{
  containers.web = {
    config = { config, pkgs, ... }: {
      environment.systemPackages =  ( with pkgs; [
        firefox keepassx-community
      ] );
    };
  };
}
