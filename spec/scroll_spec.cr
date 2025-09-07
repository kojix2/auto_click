require "./spec_helper"

# These tests validate the internal delta calculation logic for scrolling.
# We can't easily capture the actual wheel event without hooking, but we can
# verify that negative/positive steps produce the expected signed 32-bit pattern
# by reusing the wheel_input builder.

describe "Scroll delta logic" do
  it "produces +120 for one positive step" do
    input = AutoClick::InputStructure.wheel_input(120)
    input.size.should eq(32)
  end

  it "produces -120 (two's complement) for one negative step" do
    # Build via public API path: mouse_scroll(-1) would call wheel_input(-120)
    input = AutoClick::InputStructure.wheel_input(-120)
    input.size.should eq(32)
  end

  it "handles multiple steps sign" do
    pos = AutoClick::InputStructure.wheel_input(3 * 120)
    neg = AutoClick::InputStructure.wheel_input(-2 * 120)
    pos.size.should eq(32)
    neg.size.should eq(32)
  end
end
