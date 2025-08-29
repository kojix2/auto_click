require "../src/auto_click"

# Example usage of AutoClick library
puts "AutoClick Crystal Library Example"
puts "================================="

# Method 1: Include the module
include AutoClick

# Get screen resolution
width, height = get_screen_resolution
puts "Screen resolution: #{width}x#{height}"

# Get current cursor position
x, y = cursor_position
puts "Current cursor position: (#{x}, #{y})"

# Move cursor to center of screen
puts "Moving cursor to center of screen..."
mouse_move_percentage(0.5, 0.5)
sleep(1)

# Perform a left click
puts "Performing left click..."
left_click
sleep(1)

# Type some text
puts "Typing text..."
type("Hello from Crystal AutoClick!")
sleep(1)

# Press Enter
puts "Pressing Enter..."
key_stroke("enter")
sleep(1)

# Use key combination (Ctrl+A to select all)
puts "Selecting all text (Ctrl+A)..."
select_all
sleep(1)

# Copy the text (Ctrl+C)
puts "Copying text (Ctrl+C)..."
copy
sleep(1)

# Move cursor and paste
puts "Moving cursor and pasting..."
mouse_move(100, 100)
left_click
paste
sleep(1)

# Demonstrate mouse scrolling
puts "Scrolling up..."
scroll_up(3)
sleep(1)

puts "Scrolling down..."
scroll_down(3)
sleep(1)

# Demonstrate key state checking
caps_state = key_toggled?("capslock")
puts "Caps Lock is #{caps_state ? "ON" : "OFF"}"

# Demonstrate smooth mouse movement
puts "Smooth mouse movement..."
smooth_move(200, 200, steps: 20, delay: 0.02)
sleep(1)

# Method 2: Using as namespace
puts "Using AutoClick as namespace..."
AutoClick.mouse_move(300, 300)
AutoClick.right_click
sleep(1)

# Method 3: Using instance
puts "Using AutoClick instance..."
ac = AutoClick::Instance.new
ac.mouse_move(400, 400)
ac.double_click
sleep(1)

puts "Example completed!"
