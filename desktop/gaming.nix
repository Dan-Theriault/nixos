{ config, pkgs, ... }:

let
  basalt = pkgs.stdenv.mkDerivation rec {
    pname = "vkBasalt";
    version = "0.3.0";

    src = pkgs.fetchFromGitHub {
      owner = "DadSchoorse";
      repo = "vkBasalt";
      rev = "v0.3.0";
      sha256 = "0908dq195ijxdv3gv7h75rs5snaypppc2xifs3cjybwadfd96d58";
    };

    nativeBuildInputs = with pkgs; [ vulkan-validation-layers ];
    buildInputs = with pkgs; [ 
      vulkan-headers vulkan-tools vulkan-loader
      # vulkan-validation-layers
      spirv-tools glslang
    ];

    enableParallelBuilding = true;
    preInstall = ''
      HOME=$TMP
      LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.vulkan-validation-layers}/lib"
      XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.vulkan-validation-layers}/share"
    '';
    installPhase = ''
      mkdir -p $out
      mkdir -p $out/lib
      mkdir -p $out/layers
      ls
      ls build
      mv $TMP/.local/share/vkBasalt/libvkbasalt32.so $out/lib/libvkbasalt32.so
      mv $TMP/.local/share/vkBasalt/libvkbasalt64.so $out/lib/libvkbasalt64.so
      mv -r $TMP/.local/share/vulkan/implicit_layer.d $out/layers

    '';
    # meta = with stdenv.lib; {
    # };
  };

in
{
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
  # environment.extraInit = ''
  #   export XDG_DATA_DIRS=$XDG_DATA_DIRS:${basalt}/layers/
  # '';
  environment.systemPackages = with pkgs; [
    steam
    steam-run
    # lutris
    # basalt
    # wineWowPackages.base
    # winetricks
    # samba
    # p7zip
  ];
}
