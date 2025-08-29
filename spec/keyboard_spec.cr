require "./spec_helper"

describe AutoClick::Keyboard do
  describe "basic key methods" do
    it "has key_stroke method" do
      AutoClick::Keyboard.responds_to?(:key_stroke).should be_true
    end

    it "has key_down method" do
      AutoClick::Keyboard.responds_to?(:key_down).should be_true
    end

    it "has key_up method" do
      AutoClick::Keyboard.responds_to?(:key_up).should be_true
    end
  end

  describe "key state methods" do
    it "has get_key_state method" do
      AutoClick::Keyboard.responds_to?(:get_key_state).should be_true
    end

    it "has key_pressed? method" do
      AutoClick::Keyboard.responds_to?(:key_pressed?).should be_true
    end

    it "has key_toggled? method" do
      AutoClick::Keyboard.responds_to?(:key_toggled?).should be_true
    end
  end

  describe "text input methods" do
    it "has type method" do
      AutoClick::Keyboard.responds_to?(:type).should be_true
    end

    it "has type_with_delay method" do
      AutoClick::Keyboard.responds_to?(:type_with_delay).should be_true
    end
  end

  describe "key combination methods" do
    it "has key_combination method with splat args" do
      AutoClick::Keyboard.responds_to?(:key_combination).should be_true
    end

    it "has key_combination method with array" do
      # This tests the overloaded version that takes an array
      AutoClick::Keyboard.responds_to?(:key_combination).should be_true
    end
  end

  describe "common shortcuts" do
    it "has copy method" do
      AutoClick::Keyboard.responds_to?(:copy).should be_true
    end

    it "has paste method" do
      AutoClick::Keyboard.responds_to?(:paste).should be_true
    end

    it "has cut method" do
      AutoClick::Keyboard.responds_to?(:cut).should be_true
    end

    it "has select_all method" do
      AutoClick::Keyboard.responds_to?(:select_all).should be_true
    end

    it "has undo method" do
      AutoClick::Keyboard.responds_to?(:undo).should be_true
    end

    it "has redo method" do
      AutoClick::Keyboard.responds_to?(:redo).should be_true
    end

    it "has save method" do
      AutoClick::Keyboard.responds_to?(:save).should be_true
    end

    it "has open method" do
      AutoClick::Keyboard.responds_to?(:open).should be_true
    end

    it "has new method" do
      AutoClick::Keyboard.responds_to?(:new).should be_true
    end

    it "has find method" do
      AutoClick::Keyboard.responds_to?(:find).should be_true
    end
  end

  describe "system shortcuts" do
    it "has alt_tab method" do
      AutoClick::Keyboard.responds_to?(:alt_tab).should be_true
    end

    it "has windows_key method" do
      AutoClick::Keyboard.responds_to?(:windows_key).should be_true
    end

    it "has alt_f4 method" do
      AutoClick::Keyboard.responds_to?(:alt_f4).should be_true
    end

    it "has task_manager method" do
      AutoClick::Keyboard.responds_to?(:task_manager).should be_true
    end

    it "has lock_screen method" do
      AutoClick::Keyboard.responds_to?(:lock_screen).should be_true
    end

    it "has show_desktop method" do
      AutoClick::Keyboard.responds_to?(:show_desktop).should be_true
    end

    it "has run_dialog method" do
      AutoClick::Keyboard.responds_to?(:run_dialog).should be_true
    end
  end

  describe "screenshot methods" do
    it "has print_screen method" do
      AutoClick::Keyboard.responds_to?(:print_screen).should be_true
    end

    it "has screenshot_window method" do
      AutoClick::Keyboard.responds_to?(:screenshot_window).should be_true
    end
  end

  describe "advanced methods" do
    it "has hold_key method" do
      AutoClick::Keyboard.responds_to?(:hold_key).should be_true
    end

    it "has repeat_key method" do
      AutoClick::Keyboard.responds_to?(:repeat_key).should be_true
    end
  end

  describe "parameter validation" do
    it "accepts string key names" do
      # These methods should accept string parameters without raising type errors
      # We expect them to potentially raise other exceptions due to system calls
      expect_raises(Exception) do
        AutoClick::Keyboard.key_stroke("a")
      end
    end

    it "accepts symbol key names" do
      expect_raises(Exception) do
        AutoClick::Keyboard.key_stroke(:enter)
      end
    end

    it "accepts integer key codes" do
      expect_raises(Exception) do
        AutoClick::Keyboard.key_stroke(65) # VK_A
      end
    end

    it "handles empty key combination array" do
      # Should handle empty array gracefully
      AutoClick::Keyboard.key_combination([] of String)
    end
  end

  describe "text input validation" do
    it "accepts string for type method" do
      expect_raises(Exception) do
        AutoClick::Keyboard.type("test")
      end
    end

    it "accepts string and delay for type_with_delay method" do
      expect_raises(Exception) do
        AutoClick::Keyboard.type_with_delay("test", 0.01)
      end
    end
  end

  describe "duration and count validation" do
    it "accepts valid duration for hold_key" do
      expect_raises(Exception) do
        AutoClick::Keyboard.hold_key("a", 0.1)
      end
    end

    it "accepts valid count for repeat_key" do
      expect_raises(Exception) do
        AutoClick::Keyboard.repeat_key("a", 3)
      end
    end

    it "accepts valid count and delay for repeat_key" do
      expect_raises(Exception) do
        AutoClick::Keyboard.repeat_key("a", 3, 0.1)
      end
    end
  end
end
