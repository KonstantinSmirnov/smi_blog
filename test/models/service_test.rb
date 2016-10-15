require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  def setup
    @home_page = HomePage.first
  end

  test "should be saved with proper data" do
    service = build(:service, home_page: @home_page)
    assert service.save, "Not saved with proper data"
  end

  test "should not be saved without icon" do
    service = build(:service, home_page: @home_page, icon: "")
    assert_not service.save, "Saved without icon"
  end

  test "should not be saved without title" do
    service = build(:service, home_page: @home_page, title: "")
    assert_not service.save, "Saved without title"
  end

  test "should not be saved without content" do
    service = build(:service, home_page: @home_page, content: "")
    assert_not service.save, "Saved without content"
  end
end
