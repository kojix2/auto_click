require "./spec_helper"

describe "CapsLock shift logic" do
  it "computes shift need correctly with caps off" do
    AutoClick::Keyboard.__debug_letter_shift_needed('A', false).should be_true
    AutoClick::Keyboard.__debug_letter_shift_needed('a', false).should be_false
  end

  it "computes shift need correctly with caps on" do
    AutoClick::Keyboard.__debug_letter_shift_needed('A', true).should be_false
    AutoClick::Keyboard.__debug_letter_shift_needed('a', true).should be_true
  end

  it "respects configuration (no toggle by default)" do
    AutoClick::VirtualKey.strict_unknown_keys = false
    AutoClick::Keyboard.auto_toggle_capslock = false
    # Just ensure methods callable without error
    AutoClick::Keyboard.type("Ab")
  end

  it "legacy toggle mode still callable" do
    AutoClick::Keyboard.auto_toggle_capslock = true
    AutoClick::Keyboard.type_with_delay("Cd", 0.0)
    AutoClick::Keyboard.auto_toggle_capslock = false
  end
end
