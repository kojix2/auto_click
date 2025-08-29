# Windows INPUT structure definitions for AutoClick
#
# This module provides Crystal structs that match the Windows INPUT structure
# used by the SendInput API for mouse and keyboard events.
module AutoClick::InputStructure
  extend self

  # Input types
  INPUT_MOUSE    = 0_u32
  INPUT_KEYBOARD = 1_u32
  INPUT_HARDWARE = 2_u32

  # Mouse event flags
  MOUSEEVENTF_MOVE       = 0x0001_u32
  MOUSEEVENTF_LEFTDOWN   = 0x0002_u32
  MOUSEEVENTF_LEFTUP     = 0x0004_u32
  MOUSEEVENTF_RIGHTDOWN  = 0x0008_u32
  MOUSEEVENTF_RIGHTUP    = 0x0010_u32
  MOUSEEVENTF_MIDDLEDOWN = 0x0020_u32
  MOUSEEVENTF_MIDDLEUP   = 0x0040_u32
  MOUSEEVENTF_XDOWN      = 0x0080_u32
  MOUSEEVENTF_XUP        = 0x0100_u32
  MOUSEEVENTF_WHEEL      = 0x0800_u32
  MOUSEEVENTF_HWHEEL     = 0x1000_u32
  MOUSEEVENTF_ABSOLUTE   = 0x8000_u32

  # Keyboard event flags
  KEYEVENTF_EXTENDEDKEY = 0x0001_u32
  KEYEVENTF_KEYUP       = 0x0002_u32
  KEYEVENTF_UNICODE     = 0x0004_u32
  KEYEVENTF_SCANCODE    = 0x0008_u32

  # Create mouse input structure
  #
  # - dx: X movement or absolute position
  # - dy: Y movement or absolute position
  # - mouse_data: Additional mouse data (wheel delta, etc.)
  # - dw_flags: Mouse event flags
  # - time: Timestamp (0 for system time)
  # - extra_info: Additional info
  def mouse_input(dx : Int32, dy : Int32, mouse_data : UInt32, dw_flags : UInt32,
                  time : UInt32 = 0_u32, extra_info : UInt64 = 0_u64) : Bytes
    # INPUT structure for 64-bit Windows
    # struct INPUT {
    #   DWORD type;           // 4 bytes
    #   union {
    #     MOUSEINPUT mi;      // 24 bytes (dx, dy, mouseData, dwFlags, time, dwExtraInfo)
    #     KEYBDINPUT ki;
    #     HARDWAREINPUT hi;
    #   };
    # }
    # Total: 28 bytes + padding = 32 bytes on 64-bit

    input = Bytes.new(32)
    io = IO::Memory.new(input)

    # Write INPUT structure
    io.write_bytes(INPUT_MOUSE, IO::ByteFormat::LittleEndian) # type (4 bytes)
    io.write_bytes(dx, IO::ByteFormat::LittleEndian)          # dx (4 bytes)
    io.write_bytes(dy, IO::ByteFormat::LittleEndian)          # dy (4 bytes)
    io.write_bytes(mouse_data, IO::ByteFormat::LittleEndian)  # mouseData (4 bytes)
    io.write_bytes(dw_flags, IO::ByteFormat::LittleEndian)    # dwFlags (4 bytes)
    io.write_bytes(time, IO::ByteFormat::LittleEndian)        # time (4 bytes)
    io.write_bytes(extra_info, IO::ByteFormat::LittleEndian)  # dwExtraInfo (8 bytes)

    input
  end

  # Create keyboard input structure
  #
  # - vk: Virtual key code
  # - scan: Hardware scan code
  # - flags: Keyboard event flags
  # - time: Timestamp (0 for system time)
  # - extra_info: Additional info
  def keyboard_input(vk : UInt16, scan : UInt16 = 0_u16, flags : UInt32 = 0_u32,
                     time : UInt32 = 0_u32, extra_info : UInt64 = 0_u64) : Bytes
    # INPUT structure for 64-bit Windows
    # struct INPUT {
    #   DWORD type;           // 4 bytes
    #   union {
    #     MOUSEINPUT mi;
    #     KEYBDINPUT ki;      // 16 bytes (wVk, wScan, dwFlags, time, dwExtraInfo)
    #     HARDWAREINPUT hi;
    #   };
    # }
    # Total: 20 bytes + padding = 32 bytes on 64-bit

    input = Bytes.new(32)
    io = IO::Memory.new(input)

    # Write INPUT structure
    io.write_bytes(INPUT_KEYBOARD, IO::ByteFormat::LittleEndian) # type (4 bytes)
    io.write_bytes(vk, IO::ByteFormat::LittleEndian)             # wVk (2 bytes)
    io.write_bytes(scan, IO::ByteFormat::LittleEndian)           # wScan (2 bytes)
    io.write_bytes(flags, IO::ByteFormat::LittleEndian)          # dwFlags (4 bytes)
    io.write_bytes(time, IO::ByteFormat::LittleEndian)           # time (4 bytes)
    io.write_bytes(extra_info, IO::ByteFormat::LittleEndian)     # dwExtraInfo (8 bytes)
    # Remaining 8 bytes are padding

    input
  end

  # Send a single input event
  #
  # - input: Input structure bytes
  def send_single_input(input : Bytes) : UInt32
    User32.send_input(input, 1_u32, input.size)
  end

  # Send multiple input events
  #
  # - inputs: Array of input structure bytes
  def send_multiple_inputs(inputs : Array(Bytes)) : UInt32
    return 0_u32 if inputs.empty?

    # Concatenate all input structures
    total_size = inputs.sum(&.size)
    combined = Bytes.new(total_size)
    offset = 0

    inputs.each do |input|
      input.copy_to(combined[offset, input.size])
      offset += input.size
    end

    User32.send_input(combined, inputs.size.to_u32, inputs[0].size)
  end

  # Convenience methods for common mouse events

  def left_down_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_LEFTDOWN)
  end

  def left_up_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_LEFTUP)
  end

  def right_down_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_RIGHTDOWN)
  end

  def right_up_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_RIGHTUP)
  end

  def middle_down_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_MIDDLEDOWN)
  end

  def middle_up_input : Bytes
    mouse_input(0, 0, 0_u32, MOUSEEVENTF_MIDDLEUP)
  end

  def wheel_input(delta : Int32) : Bytes
    mouse_input(0, 0, delta.to_u32, MOUSEEVENTF_WHEEL)
  end

  # Convenience methods for common keyboard events

  def key_down_input(vk : UInt16) : Bytes
    keyboard_input(vk, flags: 0_u32)
  end

  def key_up_input(vk : UInt16) : Bytes
    keyboard_input(vk, flags: KEYEVENTF_KEYUP)
  end
end
