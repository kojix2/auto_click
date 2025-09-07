# Windows User32 API bindings for AutoClick
#
# This module provides Crystal bindings for the Windows User32.dll functions
# needed for mouse and keyboard automation.
module AutoClick::User32
  extend self

  # Load user32.dll
  @[Link("user32")]
  lib LibUser32
    # Get cursor position
    fun GetCursorPos(lpPoint : Void*) : Int32

    # Set cursor position
    fun SetCursorPos(x : Int32, y : Int32) : Int32

    # Send input events
    fun SendInput(cInputs : UInt32, pInputs : Void*, cbSize : Int32) : UInt32

    # Get key state
    fun GetKeyState(nVirtKey : Int32) : Int16

    # Get system metrics
    fun GetSystemMetrics(nIndex : Int32) : Int32
    # Get double-click time (in milliseconds)
    fun GetDoubleClickTime : UInt32
  end

  # Get current cursor position
  #
  # - point: Byte buffer to store the position (8 bytes for x,y coordinates)
  # Returns: 1 on success, 0 on failure
  def get_cursor_pos(point : Bytes) : Int32
    LibUser32.GetCursorPos(point)
  end

  # Set cursor position
  #
  # - x: X coordinate in pixels
  # - y: Y coordinate in pixels
  # Returns: 1 on success, 0 on failure
  def set_cursor_pos(x : Int32, y : Int32) : Int32
    LibUser32.SetCursorPos(x, y)
  end

  # Send input events to the system
  #
  # New canonical order matching WinAPI:
  #   UINT SendInput(UINT cInputs, LPINPUT pInputs, int cbSize);
  # - count: Number of INPUT structures
  # - inputs: Concatenated INPUT structure bytes
  # - input_size: Size of a single INPUT structure
  # Returns: Number of events successfully inserted into the input stream
  def send_input(count : UInt32, inputs : Bytes, input_size : Int32) : UInt32
    LibUser32.SendInput(count, inputs, input_size)
  end

  # Deprecated legacy parameter order kept for backward compatibility.
  # Will be removed in a future minor release.
  @[Deprecated("Use send_input(count, inputs, input_size) matching WinAPI order")]
  def send_input(inputs : Bytes, count : UInt32, input_size : Int32) : UInt32
    LibUser32.SendInput(count, inputs, input_size)
  end

  # Get the state of a virtual key
  #
  # - virt_key: Virtual key code
  # Returns: Key state (negative if pressed, positive if toggled on)
  def get_key_state(virt_key : Int32) : Int16
    LibUser32.GetKeyState(virt_key)
  end

  # Get system metrics
  #
  # - index: System metric index (0=screen width, 1=screen height)
  # Returns: The requested system metric value
  def get_system_metrics(index : Int32) : Int32
    LibUser32.GetSystemMetrics(index)
  end

  # Get system double-click time (milliseconds)
  def get_double_click_time : UInt32
    LibUser32.GetDoubleClickTime
  end
end
