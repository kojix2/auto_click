require "./spec_helper"

describe AutoClick::VirtualKey do
  describe "punctuation direct mapping" do
    {
      ";" => AutoClick::VirtualKey::VK_OEM_1,
      "=" => AutoClick::VirtualKey::VK_OEM_PLUS,
      "," => AutoClick::VirtualKey::VK_OEM_COMMA,
      "-" => AutoClick::VirtualKey::VK_OEM_MINUS,
      "." => AutoClick::VirtualKey::VK_OEM_PERIOD,
      "/" => AutoClick::VirtualKey::VK_OEM_2,
      "`" => AutoClick::VirtualKey::VK_OEM_3,
      "[" => AutoClick::VirtualKey::VK_OEM_4,
      "\\" => AutoClick::VirtualKey::VK_OEM_5,
      "]" => AutoClick::VirtualKey::VK_OEM_6,
      "'" => AutoClick::VirtualKey::VK_OEM_7,
    }.each do |char, expected_vk|
      it "maps '#{char}' to expected virtual key" do
        AutoClick::VirtualKey.get_vk_code(char).should eq(expected_vk)
      end
    end
  end

  describe "special shifted characters via SPECIAL_CHAR_MAP" do
    {
      '!' => AutoClick::VirtualKey::VK_1,
      '@' => AutoClick::VirtualKey::VK_2,
      '#' => AutoClick::VirtualKey::VK_3,
      '$' => AutoClick::VirtualKey::VK_4,
      '%' => AutoClick::VirtualKey::VK_5,
      '^' => AutoClick::VirtualKey::VK_6,
      '&' => AutoClick::VirtualKey::VK_7,
      '*' => AutoClick::VirtualKey::VK_8,
      '(' => AutoClick::VirtualKey::VK_9,
      ')' => AutoClick::VirtualKey::VK_0,
    }.each do |char, base_vk|
      it "resolves shifted '#{char}' to base key VK (#{base_vk})" do
        vk, needs_shift = AutoClick::VirtualKey.get_key_combination(char)
        vk.should eq(base_vk)
        needs_shift.should be_true
      end
    end
  end
end
