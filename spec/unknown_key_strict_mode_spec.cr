require "./spec_helper"

describe "Strict unknown key handling" do
  it "does not raise by default for unknown key" do
    AutoClick::VirtualKey.strict_unknown_keys = false
    AutoClick::VirtualKey.get_vk_code("__nope__").should eq(0)
  end

  it "raises in strict mode for unknown key" do
    AutoClick::VirtualKey.strict_unknown_keys = true
    expect_raises(ArgumentError) do
      AutoClick::VirtualKey.get_vk_code("__still_nope__")
    end
    AutoClick::VirtualKey.strict_unknown_keys = false
  end
end
