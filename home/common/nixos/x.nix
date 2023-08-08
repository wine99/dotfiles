# { pkgs, ... }:
# let
#   polybarOpts = ''
#     # ${pkgs.nitrogen}/bin/nitrogen --restore &
#     ${pkgs.pasystray}/bin/pasystray &
#     ${pkgs.blueman}/bin/blueman-applet &
#     ${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
#     # megasync &
#   '';
# in
# {
#   home.packages = with pkgs; [
#     dialog                 # Dialog boxes on the terminal (to show key bindings)
#     networkmanager_dmenu   # networkmanager on dmenu
#     networkmanagerapplet   # networkmanager applet
#     nitrogen               # wallpaper manager
#     xcape                  # keymaps modifier
#     xorg.xkbcomp           # keymaps modifier
#     xorg.xmodmap           # keymaps modifier
#     xorg.xrandr            # display manager (X Resize and Rotate protocol)
#     pavucontrol            # pulseaudio volume control
#     paprefs                # pulseaudio preferences
#     pasystray              # pulseaudio systray
#     xdotool                # for rofi-emoji to insert emojis directly
#   ];
#
#   xsession = {
#     enable = true;
#     initExtra = polybarOpts;
#
#     windowManager.xmonad = {
#       enable = true;
#       enableContribAndExtras = true;
#       extraPackages = hpkgs: [
#         hpkgs.dbus
#         hpkgs.monad-logger
#         hpkgs.xmonad-contrib
#       ];
#       config = ./xmonad.hs;
#     };
#   };
#
#   programs.rofi = {
#     enable = true;
#     terminal = "${pkgs.kitty}/bin/kitty";
#     # theme = ./theme.rafi;
#   };
# }
#

{ pkgs, ... }: {
  xsession = {
    enable = true;
    windowManager.command = "plasma_session";
  };
}
