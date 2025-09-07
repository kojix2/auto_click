require "./spec_helper"

describe "smooth_move validation" do
  it "raises on zero steps" do
    expect_raises(ArgumentError, /steps must be > 0/) do
      AutoClick::Mouse.smooth_move(10, 10, 0)
    end
  end

  it "raises on negative steps" do
    expect_raises(ArgumentError, /steps must be > 0/) do
      AutoClick::Mouse.smooth_move(10, 10, -5)
    end
  end
end
