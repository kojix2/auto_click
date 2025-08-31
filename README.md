# AutoClick for Crystal

[![test](https://github.com/kojix2/auto_click/actions/workflows/test.yml/badge.svg)](https://github.com/kojix2/auto_click/actions/workflows/test.yml)
[![Lines of Code](https://img.shields.io/endpoint?url=https%3A%2F%2Ftokei.kojix2.net%2Fbadge%2Fgithub%2Fkojix2%2Fauto_click%2Flines)](https://tokei.kojix2.net/github/kojix2/auto_click)
![Static Badge](https://img.shields.io/badge/PURE-VIBE_CODING-magenta)

A Windows GUI automation library for Crystal that provides mouse and keyboard automation capabilities by interfacing with Windows User32 API functions.

This is a Crystal port of the [Ruby AutoClick library](https://github.com/erinata/auto_click).

## Features

- **Mouse Operations**: Click, drag, move, scroll functionality
- **Keyboard Operations**: Key presses, text typing with special character support
- **System Information**: Screen resolution, cursor position, key states
- **Windows API Integration**: Direct calls to User32.dll functions
- **Key Mapping**: Support for multiple key naming conventions

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  auto_click:
    github: kojix2/auto_click
```

Then run:

```bash
shards install
```

## Usage

### Method 1: Include the module

```crystal
require "auto_click"
include AutoClick

# Mouse operations
left_click()
mouse_move(100, 100)
mouse_move_percentage(0.5, 0.5)  # Move to center of screen
right_click()
double_click()
mouse_scroll(3)  # Scroll up 3 steps

# Keyboard operations
type("Hello World!")
key_stroke("enter")
key_combination("ctrl", "c")  # Copy
copy()  # Shorthand for Ctrl+C
paste()  # Shorthand for Ctrl+V

# System information
width, height = screen_resolution()
x, y = cursor_position()
```

### Method 2: Use as namespace

```crystal
require "auto_click"

AutoClick.left_click()
AutoClick.mouse_move(100, 100)
AutoClick.type("Hello World!")
```

## API Reference

### Mouse Operations

#### Basic Clicks

- `left_click()` - Left mouse button click
- `right_click()` - Right mouse button click
- `middle_click()` - Middle mouse button click
- `double_click()` - Double click

#### Mouse State Control

- `mouse_down(button_name)` - Press and hold mouse button (`:left`, `:right`, `:middle`)
- `mouse_up(button_name)` - Release mouse button

#### Cursor Movement

- `mouse_move(x, y)` - Move cursor to coordinates
- `mouse_move_percentage(x_percent, y_percent)` - Move using screen percentage
- `cursor_position()` - Get current cursor position
- `smooth_move(x, y, steps, delay)` - Smooth cursor movement

#### Drag Operations

- `left_drag(sx, sy, ex, ey)` - Left drag from start to end coordinates
- `right_drag(sx, sy, ex, ey)` - Right drag from start to end coordinates
- `drag(sx, sy, ex, ey, button)` - Drag with specified button

#### Scroll Operations

- `mouse_scroll(steps)` - Scroll wheel (positive=up, negative=down)
- `scroll_up(steps)` - Scroll up
- `scroll_down(steps)` - Scroll down

#### Utility Methods

- `click_at(x, y, button)` - Click at specific coordinates
- `double_click_at(x, y)` - Double click at coordinates
- `mouse_button_pressed?(button)` - Check if button is pressed

### Keyboard Operations

#### Key Presses

- `key_stroke(key_name)` - Press and release key
- `key_down(key_name)` - Press and hold key
- `key_up(key_name)` - Release key

#### Text Input

- `type(text)` - Type string with automatic shift handling
- `type_with_delay(text, delay)` - Type with delay between characters

#### Key Combinations

- `key_combination(*keys)` - Press multiple keys simultaneously
- `key_combination(keys_array)` - Press keys from array

#### Common Shortcuts

- `copy()` - Ctrl+C
- `paste()` - Ctrl+V
- `cut()` - Ctrl+X
- `select_all()` - Ctrl+A
- `undo()` - Ctrl+Z
- `redo()` - Ctrl+Y
- `save()` - Ctrl+S
- `alt_tab()` - Alt+Tab
- `windows_key()` - Windows key
- `alt_f4()` - Alt+F4
- `task_manager()` - Ctrl+Shift+Esc
- `lock_screen()` - Win+L
- `show_desktop()` - Win+D
- `run_dialog()` - Win+R

#### Key State

- `get_key_state(key_name)` - Get key state
- `key_pressed?(key_name)` - Check if key is pressed
- `key_toggled?(key_name)` - Check if toggle key is on

#### Utility Methods

- `hold_key(key_name, duration)` - Hold key for duration
- `repeat_key(key_name, count, delay)` - Press key multiple times

### System Information

- `screen_resolution()` - Get screen width and height
- `cursor_position()` - Get current cursor coordinates

## Key Names

The library supports flexible key naming:

### Letters and Numbers

```crystal
"a", "b", "c", ..., "z"  # Letters (case insensitive)
"0", "1", "2", ..., "9"  # Numbers
```

### Function Keys

```crystal
"f1", "f2", ..., "f12"   # Function keys
```

### Modifier Keys

```crystal
"shift", "leftshift", "rightshift"
"ctrl", "control", "leftctrl", "rightctrl"
"alt", "leftalt", "rightalt"
"win", "windows", "leftwin", "rightwin"
```

### Special Keys

```crystal
"space", "enter", "tab", "esc", "escape"
"backspace", "delete", "insert"
"home", "end", "pageup", "pagedown"
"left", "right", "up", "down"  # Arrow keys
"capslock", "numlock", "scrolllock"
"pause", "printscreen"
```

### Symbol Keys

```crystal
"semicolon", "equal", "comma", "hyphen", "period"
"slash", "grave", "bracket", "backslash"
"closebracket", "quote"
```

## Special Characters

The library automatically handles special characters that require Shift:

```crystal
type("Hello World!")  # Automatically presses Shift for '!'
type("user@example.com")  # Handles @ symbol
type("Price: $19.99")  # Handles $ symbol
```

Supported special characters: `! @ # $ % ^ & * ( ) _ + { } | : " < > ? ~`

## Platform Support

- **Windows**: Full support (primary platform)
- **Linux/macOS**: Not supported (Windows-specific User32 API)

## Requirements

- Crystal 1.0.0 or later
- Windows operating system
- User32.dll (standard Windows library)

## Examples

See the `examples/` directory for complete usage examples.

## Architecture

The library is organized into several modules:

- `AutoClick::User32` - Windows API bindings
- `AutoClick::InputStructure` - INPUT structure definitions
- `AutoClick::VirtualKey` - Virtual key code mappings
- `AutoClick::Mouse` - Mouse operations
- `AutoClick::Keyboard` - Keyboard operations

## Contributing

1. Fork it (<https://github.com/kojix2/auto_click/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT License. See LICENSE file for details.

## Credits

This library is a Crystal port of the [Ruby AutoClick library](https://github.com/erinata/auto_click) by erinata.
