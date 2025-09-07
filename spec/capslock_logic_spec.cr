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

  it "no toggle by default" do
    AutoClick::Keyboard.input_text("Ab")
  end

  it "explicit toggle option works" do
    AutoClick::Keyboard.input_text_with_delay("Cd", 0.0, toggle_capslock: true)
  end
end
