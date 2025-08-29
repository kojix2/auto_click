require "./spec_helper"

describe AutoClick::Mouse do
  describe "mouse button methods" do
    it "has left click method" do
      AutoClick::Mouse.responds_to?(:left_click).should be_true
    end

    it "has right click method" do
      AutoClick::Mouse.responds_to?(:right_click).should be_true
    end

    it "has middle click method" do
      AutoClick::Mouse.responds_to?(:middle_click).should be_true
    end

    it "has double click method" do
      AutoClick::Mouse.responds_to?(:double_click).should be_true
    end
  end

  describe "mouse button state methods" do
    it "has mouse_down method" do
      AutoClick::Mouse.responds_to?(:mouse_down).should be_true
    end

    it "has mouse_up method" do
      AutoClick::Mouse.responds_to?(:mouse_up).should be_true
    end

    it "has mouse_button_pressed? method" do
      AutoClick::Mouse.responds_to?(:mouse_button_pressed?).should be_true
    end
  end

  describe "mouse movement methods" do
    it "has click_at method" do
      AutoClick::Mouse.responds_to?(:click_at).should be_true
    end

    it "has double_click_at method" do
      AutoClick::Mouse.responds_to?(:double_click_at).should be_true
    end

    it "has smooth_move method" do
      AutoClick::Mouse.responds_to?(:smooth_move).should be_true
    end
  end

  describe "drag methods" do
    it "has left_drag method" do
      AutoClick::Mouse.responds_to?(:left_drag).should be_true
    end

    it "has right_drag method" do
      AutoClick::Mouse.responds_to?(:right_drag).should be_true
    end

    it "has generic drag method" do
      AutoClick::Mouse.responds_to?(:drag).should be_true
    end
  end

  describe "scroll methods" do
    it "has mouse_scroll method" do
      AutoClick::Mouse.responds_to?(:mouse_scroll).should be_true
    end

    it "has scroll_up method" do
      AutoClick::Mouse.responds_to?(:scroll_up).should be_true
    end

    it "has scroll_down method" do
      AutoClick::Mouse.responds_to?(:scroll_down).should be_true
    end
  end

  describe "error handling" do
    it "raises error for invalid button in mouse_down" do
      expect_raises(ArgumentError, /Invalid button name/) do
        AutoClick::Mouse.mouse_down(:invalid)
      end
    end

    it "raises error for invalid button in mouse_up" do
      expect_raises(ArgumentError, /Invalid button name/) do
        AutoClick::Mouse.mouse_up(:invalid)
      end
    end

    it "raises error for invalid button in click_at" do
      expect_raises(ArgumentError, /Invalid button/) do
        AutoClick::Mouse.click_at(100, 100, :invalid)
      end
    end

    it "raises error for invalid button in drag" do
      expect_raises(ArgumentError, /Invalid button for dragging/) do
        AutoClick::Mouse.drag(0, 0, 100, 100, :invalid)
      end
    end

    it "raises error for invalid button in mouse_button_pressed?" do
      expect_raises(ArgumentError, /Invalid button/) do
        AutoClick::Mouse.mouse_button_pressed?(:invalid)
      end
    end
  end

  describe "valid button symbols" do
    it "accepts :left button" do
      # These should not raise errors
      expect_raises(Exception) do
        AutoClick::Mouse.mouse_down(:left)
      end
    end

    it "accepts :right button" do
      expect_raises(Exception) do
        AutoClick::Mouse.mouse_down(:right)
      end
    end

    it "accepts :middle button" do
      expect_raises(Exception) do
        AutoClick::Mouse.mouse_down(:middle)
      end
    end
  end
end
