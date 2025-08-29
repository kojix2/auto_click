# Mouse operations for AutoClick
#
# This module provides all mouse-related functionality including
# clicking, dragging, scrolling, and cursor movement.
module AutoClick::Mouse
  extend self

  # Perform a left mouse button click
  def left_click : Nil
    inputs = [
      InputStructure.left_down_input,
      InputStructure.left_up_input,
    ]
    InputStructure.send_multiple_inputs(inputs)
  end

  # Perform a right mouse button click
  def right_click : Nil
    inputs = [
      InputStructure.right_down_input,
      InputStructure.right_up_input,
    ]
    InputStructure.send_multiple_inputs(inputs)
  end

  # Perform a middle mouse button click
  def middle_click : Nil
    inputs = [
      InputStructure.middle_down_input,
      InputStructure.middle_up_input,
    ]
    InputStructure.send_multiple_inputs(inputs)
  end

  # Perform a double click
  def double_click : Nil
    left_click
    left_click
  end

  # Press and hold a mouse button
  #
  # - button_name: :left, :right, or :middle
  def mouse_down(button_name : Symbol) : Nil
    input = case button_name
            when :left
              InputStructure.left_down_input
            when :right
              InputStructure.right_down_input
            when :middle
              InputStructure.middle_down_input
            else
              raise ArgumentError.new("Invalid button name: #{button_name}. Use :left, :right, or :middle")
            end

    InputStructure.send_single_input(input)
  end

  # Release a mouse button
  #
  # - button_name: :left, :right, or :middle
  def mouse_up(button_name : Symbol) : Nil
    input = case button_name
            when :left
              InputStructure.left_up_input
            when :right
              InputStructure.right_up_input
            when :middle
              InputStructure.middle_up_input
            else
              raise ArgumentError.new("Invalid button name: #{button_name}. Use :left, :right, or :middle")
            end

    InputStructure.send_single_input(input)
  end

  # Perform a left mouse drag operation
  #
  # - sx: Start X coordinate
  # - sy: Start Y coordinate
  # - ex: End X coordinate
  # - ey: End Y coordinate
  def left_drag(sx : Int32, sy : Int32, ex : Int32, ey : Int32) : Nil
    # Move to start position
    User32.set_cursor_pos(sx, sy)
    sleep(0.1)

    # Press left button
    mouse_down(:left)
    sleep(0.1)

    # Move to end position
    User32.set_cursor_pos(ex, ey)
    sleep(0.1)

    # Release left button
    mouse_up(:left)
    sleep(0.1)
  end

  # Perform a right mouse drag operation
  #
  # - sx: Start X coordinate
  # - sy: Start Y coordinate
  # - ex: End X coordinate
  # - ey: End Y coordinate
  def right_drag(sx : Int32, sy : Int32, ex : Int32, ey : Int32) : Nil
    # Move to start position
    User32.set_cursor_pos(sx, sy)
    sleep(0.1)

    # Press right button
    mouse_down(:right)
    sleep(0.1)

    # Move to end position
    User32.set_cursor_pos(ex, ey)
    sleep(0.1)

    # Release right button
    mouse_up(:right)
    sleep(0.1)
  end

  # Scroll the mouse wheel
  #
  # - steps: Number of scroll steps (positive = up/forward, negative = down/backward)
  def mouse_scroll(steps : Int32) : Nil
    # Each step is 120 units in Windows
    delta = steps * 120
    input = InputStructure.wheel_input(delta)
    InputStructure.send_single_input(input)
  end

  # Scroll up by specified steps
  #
  # - steps: Number of steps to scroll up (default: 1)
  def scroll_up(steps : Int32 = 1) : Nil
    mouse_scroll(steps.abs)
  end

  # Scroll down by specified steps
  #
  # - steps: Number of steps to scroll down (default: 1)
  def scroll_down(steps : Int32 = 1) : Nil
    mouse_scroll(-steps.abs)
  end

  # Click at specific coordinates
  #
  # - x: X coordinate
  # - y: Y coordinate
  # - button: Mouse button to click (:left, :right, :middle)
  def click_at(x : Int32, y : Int32, button : Symbol = :left) : Nil
    User32.set_cursor_pos(x, y)
    case button
    when :left
      left_click
    when :right
      right_click
    when :middle
      middle_click
    else
      raise ArgumentError.new("Invalid button: #{button}. Use :left, :right, or :middle")
    end
  end

  # Double click at specific coordinates
  #
  # - x: X coordinate
  # - y: Y coordinate
  def double_click_at(x : Int32, y : Int32) : Nil
    User32.set_cursor_pos(x, y)
    double_click
  end

  # Drag from one point to another with specified button
  #
  # - sx: Start X coordinate
  # - sy: Start Y coordinate
  # - ex: End X coordinate
  # - ey: End Y coordinate
  # - button: Mouse button to use for dragging (:left, :right)
  def drag(sx : Int32, sy : Int32, ex : Int32, ey : Int32, button : Symbol = :left) : Nil
    case button
    when :left
      left_drag(sx, sy, ex, ey)
    when :right
      right_drag(sx, sy, ex, ey)
    else
      raise ArgumentError.new("Invalid button for dragging: #{button}. Use :left or :right")
    end
  end

  # Move mouse in a smooth motion (with intermediate steps)
  #
  # - x: Target X coordinate
  # - y: Target Y coordinate
  # - steps: Number of intermediate steps (default: 10)
  # - delay: Delay between steps in seconds (default: 0.01)
  def smooth_move(x : Int32, y : Int32, steps : Int32 = 10, delay : Float64 = 0.01) : Nil
    # Get current cursor position
    point = Bytes.new(8)
    User32.get_cursor_pos(point)
    current_x, current_y = point.to_unsafe.as(Int32*).to_slice(2)

    dx = (x - current_x).to_f / steps
    dy = (y - current_y).to_f / steps

    steps.times do |i|
      intermediate_x = (current_x + dx * (i + 1)).to_i32
      intermediate_y = (current_y + dy * (i + 1)).to_i32
      User32.set_cursor_pos(intermediate_x, intermediate_y)
      sleep(delay) if delay > 0
    end

    # Ensure we end up exactly at the target
    User32.set_cursor_pos(x, y)
  end

  # Check if mouse button is currently pressed
  #
  # - button: Mouse button to check (:left, :right, :middle)
  # Returns: true if button is pressed, false otherwise
  def mouse_button_pressed?(button : Symbol) : Bool
    vk_code = case button
              when :left
                VirtualKey::VK_LBUTTON
              when :right
                VirtualKey::VK_RBUTTON
              when :middle
                VirtualKey::VK_MBUTTON
              else
                raise ArgumentError.new("Invalid button: #{button}. Use :left, :right, or :middle")
              end

    state = User32.get_key_state(vk_code)
    (state & 0x8000) != 0 # Check if high bit is set (pressed)
  end
end
