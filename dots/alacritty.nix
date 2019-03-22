{ config, pkgs }:
# Configuration for Alacritty, the GPU enhanced terminal emulator

let
  theme = import ../theme.nix;
in
''
env:
  TERM: xterm-256color

# Window dimensions in character columns and lines
# (changes require restart)
window.dimensions:
  columns: 80
  lines: 24

# Adds this many blank pixels of padding around the window
# Units are physical pixels; this is not DPI aware.
# (change requires restart)
window.padding:
  x: 10
  y: 10
dynamic_padding: true

# The FreeType rasterizer needs to know the device DPI for best results
# (changes require restart)
dpi:
  x: 192.0
  y: 192.0

# Display tabs using this many cells (changes require restart)
tabspaces: 4

# When true, bold text is drawn using the bright variant of colors.
draw_bold_text_with_bright_colors: true

# Font configuration (changes require restart)
font:
  # The normal (roman) font face to use.
  normal:
    family: monospace
    # Style can be specified to pick a specific face.
    # style: Regular

  # The bold font face
  bold:
    family: monospace
    # style: Bold

  # The italic font face
  italic:
    family: monospace
    # style: Italic

  # Point size of the font
  size: 10.0

  # Offset is the extra space around each character. offset.y can be thought of
  # as modifying the linespacing, and offset.x as modifying the letter spacing.
  offset:
    x: 0
    y: 1

  # Glyph offset determines the locations of the glyphs within their cells with
  # the default being at the bottom. Increase the x offset to move the glyph to
  # the right, increase the y offset to move the glyph upward.
  glyph_offset:
    x: 0
    y: 0

# Should display the render timer
render_timer: false

colors:
  # Default colors
  primary:
    background: '${theme.background}'
    foreground: '${theme.foreground}'

  cursor: # used if `custom_cursor_colors` is true
    text: '0x000000'
    cursor: '0xffffff'

  # Normal colors
  normal:
    black:   '${theme.black1}'
    red:   '${theme.red1}'
    green:   '${theme.green1}'
    yellow:   '${theme.yellow1}'
    blue:   '${theme.blue1}'
    magenta:   '${theme.magenta1}'
    cyan:   '${theme.cyan1}'
    white:   '${theme.white1}'

  # Bright colors
  bright:
    black:   '${theme.black2}'
    red:   '${theme.red2}'
    green:   '${theme.green2}'
    yellow:   '${theme.yellow2}'
    blue:   '${theme.blue2}'
    magenta:   '${theme.magenta2}'
    cyan:   '${theme.cyan2}'
    white:   '${theme.white2}'

  # Dim colors (Optional)
  # dim:
  #   black:   '0x333333'
  #   red:     '0xf2777a'
  #   green:   '0x99cc99'
  #   yellow:  '0xffcc66'
  #   blue:    '0x6699cc'
  #   magenta: '0xcc99cc'
  #   cyan:    '0x66cccc'
  #   white:   '0xdddddd'

# To completely disable the visual bell, set its duration to 0.
visual_bell:
  animation: EaseOutExpo
  duration: 0

# Background opacity
background_opacity: 1.0

key_bindings:
  - { key: V,        mods: Control|Shift,    action: Paste               }
  - { key: C,        mods: Control|Shift,    action: Copy                }

mouse_bindings:
  - { mouse: Middle, action: PasteSelection }

mouse:
  double_click: { threshold: 300 }
  triple_click: { threshold: 300 }

selection:
  semantic_escape_chars: ",│`|:\"' ()[]{}<>"

# Live config reload (changes require restart)
live_config_reload: false
''
