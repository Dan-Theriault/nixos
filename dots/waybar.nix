{ pkgs }:

let
  theme = import ../theme.nix;
in
{
  style = pkgs.writeText "waybar-style" ''
    * {
        border: none;
        border-radius: 0;
        font-family: sans-serif;
        font-size: 14px;
        min-height: 0;
        color: ${theme.foreground};
    }

    window#waybar {
        border-top: 2px solid ${theme.border};
        background: ${theme.background};
        color: ${theme.foreground};
    }

    #workspaces, #clock, #battery, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #tray {
        border: 2px solid ${theme.border};
        padding: 3px 9px;
        margin: 7px 2px 5px 2px;
    }

    #workspaces {
        background-color: ${theme.black1};
        padding: 0px 0px;
    }

    #workspaces button {
        padding: 3px 7px;
        margin: 0px;
        background: transparent;
    }

    #workspaces button.focused {
        background: ${theme.red1};
        font-size: 20px;
    }

    #mode { font-size: 10px; }

    #clock { background-color: ${theme.black1}; }

    #battery { background-color: #ffffff; }

    #battery.charging { background-color: #26A65B; }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }

    #battery.critical:not(.charging) {
        background: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu { background: ${theme.black1}; }

    #memory { background: ${theme.black1}; }

    #backlight { background: ${theme.black1}; }

    #network { background: ${theme.black1}; }
    #network.disconnected { background: ${theme.red1}; }

    #pulseaudio { background: ${theme.black1}; }
    #pulseaudio.muted { background: ${theme.red1}; }

    #custom-spotify { background: ${theme.black1}; }

    #temperature { background: ${theme.black1}; }
    #temperature.critical { background: ${theme.red1}; }

    #tray { background-color: ${theme.black1}; }

    #idle_inhibitor { background-color: #2d3436; }
    #idle_inhibitor.activated { background-color: #ecf0f1; }
  '';

  config = pkgs.writeText "waybar-config" ''
    {
        "layer": "top", 
        "position": "bottom", 
        "height": 45, 
        "modules-left": ["clock", "sway/workspaces", "sway/mode" ], 
        "modules-center": ["sway/window"],
        "modules-right": ["pulseaudio", "cpu", "memory", "temperature", "backlight", "network"],
        "sway/workspaces": { 
             "disable-scroll": true, 
             "all-outputs": true, 
             "format": "{name}",
             "format-icons": { 
                "1": "", 
                "2": "", 
                "3": "", 
                "4": "", 
                "5": "", 
                "6": "", 
                "7": "", 
                "8": "", 
                "5": "", 
                "10": "" 
                // "urgent": "",
                // "focused": "", 
                // "default": ""
            } 
        }, 
        "sway/mode": {
            "format": "[{}]"
        },
        "tray": {
            // "icon-size": 21,
            "spacing": 10
        },
        "clock": {
            "tooltip-format": "{:%Y-%m-%d | %H:%M}",
            "format": "{:%R | %a, %b %d}"
        },
        "cpu": {
            "format": "{usage}% "
        },
        "memory": {
            "format": "{}% "
        },
        "temperature": {
            // "thermal-zone": 2,
            // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
            "critical-threshold": 80,
            // "format-critical": "{temperatureC}°C ",
            "format": "{temperatureF}°F "
        },
        "backlight": {
            // "device": "acpi_video1",
            "format": "{percent}% {icon}",
            "format-icons": ["", ""]
        },
        "battery": {
            "states": {
                // "good": 95,
                "warning": 30,
                "critical": 15
            },
            "format": "{capacity}% {icon}",
            // "format-good": "", // An empty format will hide the module
            // "format-full": "",
            "format-icons": ["", "", "", "", ""]
        },
        "battery#bat2": {
            "bat": "BAT2"
        },
        "network": {
            "format-wifi": "{essid} ({signalStrength}%) ",
            "format-ethernet": "{ifname}: {ipaddr}/{cidr} ",
            "format-disconnected": "Disconnected ⚠"
        },
        "pulseaudio": {
            //"scroll-step": 1,
            "format": "{volume}% {icon}",
            "format-bluetooth": "{volume}% {icon}",
            "format-muted": "--- ",
            "format-icons": {
                "headphones": "",
                "handsfree": "",
                "headset": "",
                "phone": "",
                "portable": "",
                "car": "",
                "default": ["", ""]
            },
            "on-click": "pactl set-sink-mute 0 toggle"
        }
    }
  '';
}
