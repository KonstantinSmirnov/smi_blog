require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "shoud not be saved without name" do
    category = build(:category, name: "")
    assert_not category.save, "Saved without name."
  end

  test "should be saved with proper name" do
    category = build(:category)
    assert category.save, "Not saved with proper name."
  end

  test "should not be saved with not unique name" do
    category = create(:category, name: "test")
    category2 = build(:category, name: "test")
    assert_not category2.save, "Saved with not unique name."
  end

  test "should create slug automatically" do
    category = create(:category, name: "this is a test category")
    assert_equal category.slug, "this-is-a-test-category"
  end

  test "should replace non-character symbols with dashes" do
    category = create(:category, name: '!23this-is$%^a_testcatego23ry?')
    assert_equal category.slug, "-23this-is---a-testcatego23ry-"
  end

  test "should translate slug in english" do
    category = create(:category, name: "Это пример категории")
    assert_equal category.slug, "jeto-primer-kategorii"
  end

end
