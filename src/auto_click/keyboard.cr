# Keyboard operations for AutoClick
#
# This module provides all keyboard-related functionality including
# key presses, text typing, and key state checking.
module AutoClick::Keyboard
  extend self

  # Press and release a key (key stroke)
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  def key_stroke(key_name : String | Symbol | Int32) : Nil
    key_down(key_name)
    key_up(key_name)
  end

  # Press and hold a key
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  def key_down(key_name : String | Symbol | Int32) : Nil
    vk_code = VirtualKey.get_vk_code(key_name)
    return if vk_code == 0

    input = InputStructure.key_down_input(vk_code.to_u16)
    InputStructure.send_single_input(input)
  end

  # Release a key
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  def key_up(key_name : String | Symbol | Int32) : Nil
    vk_code = VirtualKey.get_vk_code(key_name)
    return if vk_code == 0

    input = InputStructure.key_up_input(vk_code.to_u16)
    InputStructure.send_single_input(input)
  end

  # Get the current state of a key
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  # Returns: Key state (negative if pressed, positive if toggled on for toggle keys)
  def get_key_state(key_name : String | Symbol | Int32) : Int16
    vk_code = VirtualKey.get_vk_code(key_name)
    return 0_i16 if vk_code == 0

    User32.get_key_state(vk_code)
  end

  # Check if a key is currently pressed
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  # Returns: true if key is pressed, false otherwise
  def key_pressed?(key_name : String | Symbol | Int32) : Bool
    state = get_key_state(key_name)
    (state & 0x8000) != 0 # Check if high bit is set (pressed)
  end

  # Check if a toggle key is currently on (like Caps Lock, Num Lock)
  #
  # - key_name: Key name (String, Symbol, or Integer virtual key code)
  # Returns: true if toggle key is on, false otherwise
  def key_toggled?(key_name : String | Symbol | Int32) : Bool
    state = get_key_state(key_name)
    (state & 0x0001) != 0 # Check if low bit is set (toggled)
  end

  # Type a string of text
  #
  # - text: String to type
  def type(text : String) : Nil
    # Check if Caps Lock is on and turn it off if needed
    caps_on = key_toggled?("capslock")
    if caps_on
      key_stroke("capslock")
    end

    text.each_char do |char|
      type_char(char)
    end

    # Restore Caps Lock state if it was on
    if caps_on
      key_stroke("capslock")
    end
  end

  # Type a single character
  #
  # - char: Character to type
  private def type_char(char : Char) : Nil
    vk_code, needs_shift = VirtualKey.get_key_combination(char)
    return if vk_code == 0

    inputs = [] of Bytes

    # Press Shift if needed
    if needs_shift
      inputs << InputStructure.key_down_input(VirtualKey::VK_SHIFT.to_u16)
    end

    # Press the key
    inputs << InputStructure.key_down_input(vk_code.to_u16)
    inputs << InputStructure.key_up_input(vk_code.to_u16)

    # Release Shift if it was pressed
    if needs_shift
      inputs << InputStructure.key_up_input(VirtualKey::VK_SHIFT.to_u16)
    end

    InputStructure.send_multiple_inputs(inputs)
  end

  # Send key combination (e.g., Ctrl+C, Alt+Tab)
  #
  # - keys: Array of key names to press simultaneously
  def key_combination(*keys : String | Symbol | Int32) : Nil
    key_combination(keys.to_a)
  end

  # Send key combination from array
  #
  # - keys: Array of key names to press simultaneously
  def key_combination(keys : Array(String | Symbol | Int32)) : Nil
    return if keys.empty?

    # Convert all keys to virtual key codes
    vk_codes = keys.map { |key| VirtualKey.get_vk_code(key).to_u16 }.reject(&.zero?)
    return if vk_codes.empty?

    inputs = [] of Bytes

    # Press all keys down
    vk_codes.each do |vk|
      inputs << InputStructure.key_down_input(vk)
    end

    # Release all keys in reverse order
    vk_codes.reverse.each do |vk|
      inputs << InputStructure.key_up_input(vk)
    end

    InputStructure.send_multiple_inputs(inputs)
  end

  # Common key combinations

  # Copy (Ctrl+C)
  def copy : Nil
    key_combination("ctrl", "c")
  end

  # Paste (Ctrl+V)
  def paste : Nil
    key_combination("ctrl", "v")
  end

  # Cut (Ctrl+X)
  def cut : Nil
    key_combination("ctrl", "x")
  end

  # Select All (Ctrl+A)
  def select_all : Nil
    key_combination("ctrl", "a")
  end

  # Undo (Ctrl+Z)
  def undo : Nil
    key_combination("ctrl", "z")
  end

  # Redo (Ctrl+Y)
  def redo : Nil
    key_combination("ctrl", "y")
  end

  # Save (Ctrl+S)
  def save : Nil
    key_combination("ctrl", "s")
  end

  # Open (Ctrl+O)
  def open : Nil
    key_combination("ctrl", "o")
  end

  # New (Ctrl+N)
  def new : Nil
    key_combination("ctrl", "n")
  end

  # Find (Ctrl+F)
  def find : Nil
    key_combination("ctrl", "f")
  end

  # Alt+Tab (switch windows)
  def alt_tab : Nil
    key_combination("alt", "tab")
  end

  # Windows key (open start menu)
  def windows_key : Nil
    key_stroke("win")
  end

  # Alt+F4 (close window)
  def alt_f4 : Nil
    key_combination("alt", "f4")
  end

  # Ctrl+Shift+Esc (task manager)
  def task_manager : Nil
    key_combination("ctrl", "shift", "esc")
  end

  # Win+L (lock screen)
  def lock_screen : Nil
    key_combination("win", "l")
  end

  # Win+D (show desktop)
  def show_desktop : Nil
    key_combination("win", "d")
  end

  # Win+R (run dialog)
  def run_dialog : Nil
    key_combination("win", "r")
  end

  # Print Screen
  def print_screen : Nil
    key_stroke("printscreen")
  end

  # Alt+Print Screen (screenshot active window)
  def screenshot_window : Nil
    key_combination("alt", "printscreen")
  end

  # Type text with delay between characters
  #
  # - text: String to type
  # - delay: Delay between characters in seconds (default: 0.05)
  def type_with_delay(text : String, delay : Float64 = 0.05) : Nil
    # Check if Caps Lock is on and turn it off if needed
    caps_on = key_toggled?("capslock")
    if caps_on
      key_stroke("capslock")
    end

    text.each_char do |char|
      type_char(char)
      sleep(delay) if delay > 0
    end

    # Restore Caps Lock state if it was on
    if caps_on
      key_stroke("capslock")
    end
  end

  # Hold a key for a specified duration
  #
  # - key_name: Key name to hold
  # - duration: Duration to hold the key in seconds
  def hold_key(key_name : String | Symbol | Int32, duration : Float64) : Nil
    key_down(key_name)
    sleep(duration)
    key_up(key_name)
  end

  # Press a key multiple times
  #
  # - key_name: Key name to press
  # - count: Number of times to press the key
  # - delay: Delay between presses in seconds (default: 0.1)
  def repeat_key(key_name : String | Symbol | Int32, count : Int32, delay : Float64 = 0.1) : Nil
    count.times do
      key_stroke(key_name)
      sleep(delay) if delay > 0
    end
  end
end
