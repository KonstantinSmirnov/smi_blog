require 'test_helper'

class SocialTest < ActiveSupport::TestCase
  test "should not save empty social icon" do
    social = Social.new
    assert_not social.save, "Save with empty fields"
  end

  test "should not save without icon_text" do
    social = build(:social, icon_text: "")
    assert_not social.save, "Save without icon_text"
  end

  test "should not save without link" do
    social = build(:social, link: "")
    assert_not social.save, "Save without link"
  end

  test "can be destroyed" do
    before = Social.count
    social = create(:social)
    after = Social.count
    assert_equal after - before, 1, "Can not be destroyed"
  end
end
