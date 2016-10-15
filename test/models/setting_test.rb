require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test "should save with correct data" do
    setting = build(:setting)
    assert setting.save, "Not saved with proper data"
  end

  test "should not save without website_title" do
    setting = build(:setting, website_title: "")
    assert_not setting.save, "Saved without website_title"
  end

  test "should not save without default_description" do
    setting = build(:setting, default_description: "")
    assert_not setting.save, "Saved without default_description"
  end

  test "should not save without default_keywords" do
    setting = build(:setting, default_keywords: "")
    assert_not setting.save, "Saved without default_keywords"
  end

  test "shoud not save without twitter_share_via_account" do
    setting = build(:setting, twitter_share_via_account: "")
    assert_not setting.save, "Saved without twitter_share_via_account"
  end
end
