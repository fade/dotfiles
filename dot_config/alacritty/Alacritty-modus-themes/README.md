<div align="center"> 

modus-themes for [Alacritty](https://github.com/alacritty/alacritty/). 
</div>
<div align="center"> 

Originally developed for [Emacs](https://www.gnu.org/software/emacs/) by [Protesilaos Stavrou](https://protesilaos.com/). 
</div>

## Usage

1. Clone this repository next to your Alacritty config file (usually stored at
   `~/.config/alacritty/alacritty.yaml`), with e.g.
   
```shell
 git clone https://codeberg.org/Zi0n7/Alacritty-modus-themes.git ~/.config/alacritty/modus-themes
```

2. Import the theme in your `alacritty.yaml`:

```shell
import:
# uncomment the theme you want to use:
#  - ~/.config/alacritty/modus-themes/modus-operandi.yaml # Light theme.
  - ~/.config/alacritty/modus-themes/modus-vivendi.yaml  # Dark theme. (default)
  
```

3. OR copy the code below in your `alacritty.yaml`.

## modus-vivendi (Dark theme)

```yaml
  
  # modus-vivendi (Dark theme)
  colors:
    primary:
      background: '#000000'
      foreground: '#ffffff'
      # Bright and dim foreground colors
      dim_foreground: '#1e1e1e'
      bright_foreground: '#ffffff'
      # Normal colors
      normal:
        black:   '#000000'
        red:     '#ff5f59'
        green:   '#44bc44'
        yellow:  '#d0bc00'
        blue:    '#2fafff'
        magenta: '#feacd0'
        cyan:    '#00d3d0'
        white:   '#ffffff'
       # Bright colors
       bright:
         black:   '#000000'
         red:     '#ff5f5f'
         green:   '#44df44'
         yellow:  '#efef00'
         blue:    '#338fff'
         magenta: '#ff66ff'
         cyan:    '#9ac8e0'
         white:   '#ffffff'
       # Dim colors
       dim:
         black:   '#000000'
         red:     '#ff9580'
         green:   '#88ca9f'
         yellow:  '#d2b580'
         blue:    '#82b0ec'
         magenta: '#caa6df'
         cyan:    '#9ac8e0'
         white:   '#989898'

```

## modus-operandi (Light-theme)

```yaml

  # modus-operandi (Light theme)
  colors:
    primary:
      background: '#ffffff'
      foreground: '#000000'
      # Bright and dim foreground colors
      dim_foreground: '#595959'
      bright_foreground: '#ffffff'
      # Normal colors
      normal:
        black:   '#000000'
        red:     '#a60000'
        green:   '#006800'
        yellow:  '#6f5500'
        blue:    '#0031a9'
        magenta: '#721045'
        cyan:    '#005e8b'
        white:   '#ffffff'
      # Bright colors
      bright:
        black:   '#000000'
        red:     '#d00000'
        green:   '#008900'
        yellow:  '#808000'
        blue:    '#0000ff'
        magenta: '#dd22dd'
        cyan:    '#008899'
        white:   '#ffffff'
      # Dim colors
      dim:
        black:   '#f0f0f0'
        red:     '#7f0000'
        green:   '#2a5045'
        yellow:  '#624416'
        blue:    '#003497'
        magenta: '#7c318f'
        cyan:    '#005077'
        white:   '#595959'

```

## LICENSE
[MIT](https://codeberg.org/Zi0n7/Alacritty-modus-themes/src/branch/master/LICENSE)
