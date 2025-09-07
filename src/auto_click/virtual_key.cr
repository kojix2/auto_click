# Virtual Key Code mappings for AutoClick
#
# This module provides mapping between key names and Windows Virtual Key Codes
# supporting multiple naming conventions for flexibility.
module AutoClick::VirtualKey
  extend self

  # Virtual Key Code constants
  VK_LBUTTON  = 0x01
  VK_RBUTTON  = 0x02
  VK_CANCEL   = 0x03
  VK_MBUTTON  = 0x04
  VK_XBUTTON1 = 0x05
  VK_XBUTTON2 = 0x06
  VK_BACK     = 0x08
  VK_TAB      = 0x09
  VK_CLEAR    = 0x0C
  VK_RETURN   = 0x0D
  VK_SHIFT    = 0x10
  VK_CONTROL  = 0x11
  VK_MENU     = 0x12
  VK_PAUSE    = 0x13
  VK_CAPITAL  = 0x14
  VK_ESCAPE   = 0x1B
  VK_SPACE    = 0x20
  VK_PRIOR    = 0x21
  VK_NEXT     = 0x22
  VK_END      = 0x23
  VK_HOME     = 0x24
  VK_LEFT     = 0x25
  VK_UP       = 0x26
  VK_RIGHT    = 0x27
  VK_DOWN     = 0x28
  VK_SELECT   = 0x29
  VK_PRINT    = 0x2A
  VK_EXECUTE  = 0x2B
  VK_SNAPSHOT = 0x2C
  VK_INSERT   = 0x2D
  VK_DELETE   = 0x2E
  VK_HELP     = 0x2F

  # Number keys (main keyboard)
  VK_0 = 0x30
  VK_1 = 0x31
  VK_2 = 0x32
  VK_3 = 0x33
  VK_4 = 0x34
  VK_5 = 0x35
  VK_6 = 0x36
  VK_7 = 0x37
  VK_8 = 0x38
  VK_9 = 0x39

  # Letter keys
  VK_A = 0x41
  VK_B = 0x42
  VK_C = 0x43
  VK_D = 0x44
  VK_E = 0x45
  VK_F = 0x46
  VK_G = 0x47
  VK_H = 0x48
  VK_I = 0x49
  VK_J = 0x4A
  VK_K = 0x4B
  VK_L = 0x4C
  VK_M = 0x4D
  VK_N = 0x4E
  VK_O = 0x4F
  VK_P = 0x50
  VK_Q = 0x51
  VK_R = 0x52
  VK_S = 0x53
  VK_T = 0x54
  VK_U = 0x55
  VK_V = 0x56
  VK_W = 0x57
  VK_X = 0x58
  VK_Y = 0x59
  VK_Z = 0x5A

  # Windows keys
  VK_LWIN = 0x5B
  VK_RWIN = 0x5C
  VK_APPS = 0x5D

  # Numpad keys
  VK_NUMPAD0   = 0x60
  VK_NUMPAD1   = 0x61
  VK_NUMPAD2   = 0x62
  VK_NUMPAD3   = 0x63
  VK_NUMPAD4   = 0x64
  VK_NUMPAD5   = 0x65
  VK_NUMPAD6   = 0x66
  VK_NUMPAD7   = 0x67
  VK_NUMPAD8   = 0x68
  VK_NUMPAD9   = 0x69
  VK_MULTIPLY  = 0x6A
  VK_ADD       = 0x6B
  VK_SEPARATOR = 0x6C
  VK_SUBTRACT  = 0x6D
  VK_DECIMAL   = 0x6E
  VK_DIVIDE    = 0x6F

  # Function keys
  VK_F1  = 0x70
  VK_F2  = 0x71
  VK_F3  = 0x72
  VK_F4  = 0x73
  VK_F5  = 0x74
  VK_F6  = 0x75
  VK_F7  = 0x76
  VK_F8  = 0x77
  VK_F9  = 0x78
  VK_F10 = 0x79
  VK_F11 = 0x7A
  VK_F12 = 0x7B
  VK_F13 = 0x7C
  VK_F14 = 0x7D
  VK_F15 = 0x7E
  VK_F16 = 0x7F
  VK_F17 = 0x80
  VK_F18 = 0x81
  VK_F19 = 0x82
  VK_F20 = 0x83
  VK_F21 = 0x84
  VK_F22 = 0x85
  VK_F23 = 0x86
  VK_F24 = 0x87

  # Lock keys
  VK_NUMLOCK = 0x90
  VK_SCROLL  = 0x91

  # Modifier keys (left/right specific)
  VK_LSHIFT   = 0xA0
  VK_RSHIFT   = 0xA1
  VK_LCONTROL = 0xA2
  VK_RCONTROL = 0xA3
  VK_LMENU    = 0xA4
  VK_RMENU    = 0xA5

  # Symbol keys
  VK_OEM_1      = 0xBA # ';:' for US
  VK_OEM_PLUS   = 0xBB # '+' any country
  VK_OEM_COMMA  = 0xBC # ',' any country
  VK_OEM_MINUS  = 0xBD # '-' any country
  VK_OEM_PERIOD = 0xBE # '.' any country
  VK_OEM_2      = 0xBF # '/?' for US
  VK_OEM_3      = 0xC0 # '`~' for US
  VK_OEM_4      = 0xDB # '[{' for US
  VK_OEM_5      = 0xDC # '\|' for US
  VK_OEM_6      = 0xDD # ']}' for US
  VK_OEM_7      = 0xDE # ''"' for US

  # Key name to virtual key code mapping
  KEY_MAP = {
    # Letters (case insensitive)
    "a" => VK_A, "b" => VK_B, "c" => VK_C, "d" => VK_D, "e" => VK_E,
    "f" => VK_F, "g" => VK_G, "h" => VK_H, "i" => VK_I, "j" => VK_J,
    "k" => VK_K, "l" => VK_L, "m" => VK_M, "n" => VK_N, "o" => VK_O,
    "p" => VK_P, "q" => VK_Q, "r" => VK_R, "s" => VK_S, "t" => VK_T,
    "u" => VK_U, "v" => VK_V, "w" => VK_W, "x" => VK_X, "y" => VK_Y, "z" => VK_Z,

    # Numbers (main keyboard)
    "0" => VK_0, "1" => VK_1, "2" => VK_2, "3" => VK_3, "4" => VK_4,
    "5" => VK_5, "6" => VK_6, "7" => VK_7, "8" => VK_8, "9" => VK_9,

    # Function keys
    "f1" => VK_F1, "f2" => VK_F2, "f3" => VK_F3, "f4" => VK_F4, "f5" => VK_F5, "f6" => VK_F6,
    "f7" => VK_F7, "f8" => VK_F8, "f9" => VK_F9, "f10" => VK_F10, "f11" => VK_F11, "f12" => VK_F12,

    # Modifier keys
    "shift" => VK_SHIFT, "leftshift" => VK_LSHIFT, "rightshift" => VK_RSHIFT,
    "ctrl" => VK_CONTROL, "control" => VK_CONTROL, "leftctrl" => VK_LCONTROL, "rightctrl" => VK_RCONTROL,
    "alt" => VK_MENU, "leftalt" => VK_LMENU, "rightalt" => VK_RMENU,
    "win" => VK_LWIN, "windows" => VK_LWIN, "leftwin" => VK_LWIN, "rightwin" => VK_RWIN,

    # Special keys
    "space" => VK_SPACE, "enter" => VK_RETURN, "tab" => VK_TAB,
    "esc" => VK_ESCAPE, "escape" => VK_ESCAPE,
    "backspace" => VK_BACK, "delete" => VK_DELETE, "insert" => VK_INSERT,
    "home" => VK_HOME, "end" => VK_END,
    "pageup" => VK_PRIOR, "pagedown" => VK_NEXT,
    "capslock" => VK_CAPITAL, "numlock" => VK_NUMLOCK,
    "pause" => VK_PAUSE, "printscreen" => VK_SNAPSHOT,

    # Arrow keys
    "left" => VK_LEFT, "right" => VK_RIGHT, "up" => VK_UP, "down" => VK_DOWN,

    # Symbol keys
    "semicolon" => VK_OEM_1, "equal" => VK_OEM_PLUS, "comma" => VK_OEM_COMMA,
    "hyphen" => VK_OEM_MINUS, "period" => VK_OEM_PERIOD, "slash" => VK_OEM_2,
    "grave" => VK_OEM_3, "bracket" => VK_OEM_4, "backslash" => VK_OEM_5,
    "closebracket" => VK_OEM_6, "quote" => VK_OEM_7,

    # --- Direct single-character symbol mappings (missing before) ---
    # Allow direct use of punctuation like ";" or "/" in get_vk_code.
    ";" => VK_OEM_1,
    "=" => VK_OEM_PLUS,
    "," => VK_OEM_COMMA,
    "-" => VK_OEM_MINUS,
    "." => VK_OEM_PERIOD,
    "/" => VK_OEM_2,
    "`" => VK_OEM_3,
    "[" => VK_OEM_4,
    "\\" => VK_OEM_5,
    "]" => VK_OEM_6,
    "'" => VK_OEM_7,
  }

  # Special character to key combination mapping
  SPECIAL_CHAR_MAP = {
    '!' => {"1", true},  # Shift + 1
    '@' => {"2", true},  # Shift + 2
    '#' => {"3", true},  # Shift + 3
    '$' => {"4", true},  # Shift + 4
    '%' => {"5", true},  # Shift + 5
    '^' => {"6", true},  # Shift + 6
    '&' => {"7", true},  # Shift + 7
    '*' => {"8", true},  # Shift + 8
    '(' => {"9", true},  # Shift + 9
    ')' => {"0", true},  # Shift + 0
    '_' => {"-", true},  # Shift + -
    '+' => {"=", true},  # Shift + =
    '{' => {"[", true},  # Shift + [
    '}' => {"]", true},  # Shift + ]
    '|' => {"\\", true}, # Shift + \
    ':' => {";", true},  # Shift + ;
    '"' => {"'", true},  # Shift + '
    '<' => {",", true},  # Shift + ,
    '>' => {".", true},  # Shift + .
    '?' => {"/", true},  # Shift + /
    '~' => {"`", true},  # Shift + `
  }

  # Convert key name to virtual key code (Int32 overload)
  def get_vk_code(key : Int32, *, raise_unknown : Bool = false) : Int32
    key
  end

  # Convert key name to virtual key code (Symbol overload)
  def get_vk_code(key : Symbol, *, raise_unknown : Bool = false) : Int32
    get_vk_code(key.to_s, raise_unknown: raise_unknown)
  end

  # Convert key name to virtual key code (String overload)
  def get_vk_code(key : String, *, raise_unknown : Bool = false) : Int32
    # Handle single characters
    if key.size == 1
      char = key[0]

      # Check if it's a letter (convert to uppercase)
      if char.ascii_letter?
        return char.upcase.ord
      end

      # Check if it's a digit
      if char.ascii_number?
        return char.ord
      end

      # Check special characters
      if SPECIAL_CHAR_MAP.has_key?(char)
        base_key, _ = SPECIAL_CHAR_MAP[char]
        return get_vk_code(base_key, raise_unknown: raise_unknown)
      end
    end

    # Look up in key map (case insensitive)
    vk = KEY_MAP[key.downcase]?
    return vk unless vk.nil?
    raise ArgumentError.new("Unknown key name: #{key}") if raise_unknown
    0
  end

  # Check if a character requires Shift key
  def requires_shift?(char : Char) : Bool
    char.ascii_uppercase? || SPECIAL_CHAR_MAP.has_key?(char)
  end

  # Get key combination for a character
  def get_key_combination(char : Char, *, raise_unknown : Bool = false) : {Int32, Bool}
    if char.ascii_letter?
      vk = char.upcase.ord
      needs_shift = char.ascii_uppercase?
      {vk, needs_shift}
    elsif char.ascii_number?
      {char.ord, false}
    elsif SPECIAL_CHAR_MAP.has_key?(char)
      base_key, needs_shift = SPECIAL_CHAR_MAP[char]
      vk = get_vk_code(base_key, raise_unknown: raise_unknown)
      {vk, needs_shift}
    else
      # Try to find direct mapping
      vk = get_vk_code(char.to_s, raise_unknown: raise_unknown)
      raise ArgumentError.new("Unknown character: #{char}") if vk == 0 && raise_unknown
      {vk, false}
    end
  end
end
