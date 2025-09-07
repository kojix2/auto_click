require "./auto_click/user32"
require "./auto_click/input_structure"
require "./auto_click/virtual_key"
require "./auto_click/mouse"
require "./auto_click/keyboard"
require "./auto_click/version"

# AutoClick - Windows GUI automation library for Crystal
#
# This library provides mouse and keyboard automation capabilities
# by interfacing with Windows User32 API functions.
#
# Usage:
#   ```
# # Method 1: Include the module
# include AutoClick
# left_click()
# mouse_move(100, 100)
# input_text("Hello World")
#
# # Method 2: Use as namespace
# AutoClick.left_click
# AutoClick.mouse_move(100, 100)
# AutoClick.input_text("Hello World")
#   ```
module AutoClick
  extend self
  include Mouse
  include Keyboard

  # Get current screen resolution
  #
  # Returns an array containing [width, height] in pixels
  def screen_resolution : Array(Int32)
    width = User32.get_system_metrics(0)  # SM_CXSCREEN
    height = User32.get_system_metrics(1) # SM_CYSCREEN
    [width, height]
  end

  # Get current cursor position
  #
  # Returns an array containing [x, y] coordinates
  def cursor_position : Array(Int32)
    point = Bytes.new(8)
    User32.get_cursor_pos(point)
    x, y = point.unsafe_slice_of(Int32)
    [x, y]
  end

  # Move cursor to specified coordinates
  #
  # - x: X coordinate in pixels
  # - y: Y coordinate in pixels
  def mouse_move(x : Int32, y : Int32) : Nil
    User32.set_cursor_pos(x, y)
  end

  # Move cursor using percentage of screen dimensions
  #
  # - x_percent: X position as percentage (0.0 to 1.0)
  # - y_percent: Y position as percentage (0.0 to 1.0)
  def mouse_move_percentage(x_percent : Float64, y_percent : Float64) : Nil
    width, height = screen_resolution
    x = (width * x_percent).to_i32
    y = (height * y_percent).to_i32
    mouse_move(x, y)
  end
end
