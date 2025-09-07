require "./spec_helper"

describe "Strict unknown key handling" do
  it "does not raise by default for unknown key" do
    AutoClick::VirtualKey.get_vk_code("__nope__").should eq(0)
  end

  it "raises when raise_unknown passed" do
    expect_raises(ArgumentError) do
      AutoClick::VirtualKey.get_vk_code("__still_nope__", raise_unknown: true)
    end
  end
end
