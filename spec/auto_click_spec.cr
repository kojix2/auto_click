require "./spec_helper"

describe AutoClick do
  describe "module loading" do
    it "loads the main module" do
      AutoClick.should_not be_nil
    end

    it "includes Mouse module" do
      AutoClick.responds_to?(:left_click).should be_true
      AutoClick.responds_to?(:right_click).should be_true
      AutoClick.responds_to?(:mouse_move).should be_true
    end

    it "includes Keyboard module" do
      AutoClick.responds_to?(:key_stroke).should be_true
      AutoClick.responds_to?(:input_text).should be_true
      AutoClick.responds_to?(:key_combination).should be_true
    end
  end

  describe "version" do
    it "has a version number" do
      AutoClick::VERSION.should be_a(String)
      AutoClick::VERSION.should_not be_empty
    end
  end

  describe "basic methods existence" do
    it "has screen resolution method" do
      AutoClick.responds_to?(:screen_resolution).should be_true
    end

    it "has cursor position method" do
      AutoClick.responds_to?(:cursor_position).should be_true
    end

    it "has mouse movement methods" do
      AutoClick.responds_to?(:mouse_move).should be_true
      AutoClick.responds_to?(:mouse_move_percentage).should be_true
    end
  end

  describe "error handling" do
    it "raises error for invalid mouse button" do
      expect_raises(ArgumentError, /Invalid button/) do
        AutoClick.mouse_down(:invalid)
      end
    end

    it "raises error for invalid drag button" do
      expect_raises(ArgumentError, /Invalid button for dragging/) do
        AutoClick.drag(0, 0, 100, 100, :invalid)
      end
    end

    it "raises error for invalid click button" do
      expect_raises(ArgumentError, /Invalid button/) do
        AutoClick.click_at(100, 100, :invalid)
      end
    end
  end

  describe "module usage" do
    it "can be used as namespace" do
      # Test that AutoClick methods can be called directly
      AutoClick.responds_to?(:left_click).should be_true
      AutoClick.responds_to?(:key_stroke).should be_true
    end
  end
end
