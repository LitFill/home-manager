{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Desktop Environment
    dunst # Notification daemon

    # System Utilities
    arandr # GUI display management

    # Appearance
    lxappearance # GTK theme configuration
    qt5ct # Qt5 platform theme

    # Network Tools
    networkmanager_dmenu # Network manager GUI
    blueman # Bluetooth manager
  ];

  # Dunst notification daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "300x5-30+60";
        indicate_hidden = "yes";
        shrink = "no";
        transparency = 20;
        notification_height = 0;
        frame_width = 3;
        frame_color = "#8EC4D4";
        font = "JetBrains Mono 10";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        ellipsize = 20;
        markup = "full";
        icon_position = "left";
        max_icon_size = 32;
        sticky_history = "yes";
      };
      urgency_low = {
        background = "#1C1C1C";
        foreground = "#C1C1C1";
        timeout = 4;
      };
      urgency_normal = {
        background = "#285577";
        foreground = "#ECDCDC";
        timeout = 6;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        timeout = 10;
        frame_color = "#FF0000";
      };
    };
  };

  # GTK and Qt theme configuration
  gtk = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "Fusion-Dark";
    };
  };
}
