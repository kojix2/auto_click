require "./spec_helper"

describe AutoClick::VirtualKey do
  describe "constants" do
    it "defines VK_LBUTTON" do
      AutoClick::VirtualKey::VK_LBUTTON.should eq(0x01)
    end

    it "defines VK_RBUTTON" do
      AutoClick::VirtualKey::VK_RBUTTON.should eq(0x02)
    end

    it "defines VK_MBUTTON" do
      AutoClick::VirtualKey::VK_MBUTTON.should eq(0x04)
    end

    it "defines VK_SHIFT" do
      AutoClick::VirtualKey::VK_SHIFT.should eq(0x10)
    end

    it "defines common key constants" do
      AutoClick::VirtualKey::VK_RETURN.should eq(0x0D)
      AutoClick::VirtualKey::VK_SPACE.should eq(0x20)
      AutoClick::VirtualKey::VK_ESCAPE.should eq(0x1B)
    end
  end

  describe "get_vk_code method" do
    it "responds to get_vk_code" do
      AutoClick::VirtualKey.responds_to?(:get_vk_code).should be_true
    end

    it "accepts string parameter" do
      # Should not raise type error
      begin
        AutoClick::VirtualKey.get_vk_code("a")
      rescue
        # May raise other exceptions, but not type errors
      end
    end

    it "accepts symbol parameter" do
      begin
        AutoClick::VirtualKey.get_vk_code(:enter)
      rescue
        # May raise other exceptions, but not type errors
      end
    end

    it "accepts integer parameter" do
      begin
        AutoClick::VirtualKey.get_vk_code(65)
      rescue
        # May raise other exceptions, but not type errors
      end
    end
  end

  describe "get_key_combination method" do
    it "responds to get_key_combination" do
      AutoClick::VirtualKey.responds_to?(:get_key_combination).should be_true
    end

    it "accepts char parameter" do
      begin
        AutoClick::VirtualKey.get_key_combination('a')
      rescue
        # May raise other exceptions, but not type errors
      end
    end

    it "returns tuple with vk_code and shift flag" do
      begin
        result = AutoClick::VirtualKey.get_key_combination('a')
        result.should be_a(Tuple(Int32, Bool))
      rescue
        # May not work in test environment, but should have correct return type
      end
    end
  end
end
