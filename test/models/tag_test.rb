require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "should save with proper data" do
    tag = build(:tag)
    assert tag.save, "Not saved with proper data"
  end

  test "should not save without name" do
    tag = build(:tag, name: "")
    assert_not tag.save, "Saved without name"
  end

  test "should not save with not unique name" do
    tag1 = create(:tag, name: "tag1")
    tag2 = build(:tag, name: "tag1")
    assert_not tag2.save, "Saved with not unique name"
  end

  test "should have articles_count 1 by default" do
    @article = create(:article)
    tag = build(:tag)
    tag.articles << @article
    tag.save!
    assert_equal tag.articles_count, 1, "Articles count not eq 1 for new tag"
  end

  test "should update articles_count if assigned to additional articles" do
    @article1 = create(:article, slug: "article1", category: Category.first)
    @article2 = create(:article, slug: "article2", category: Category.first)
    tag = build(:tag)
    tag.articles << @article1
    tag.articles << @article2
    tag.save!
    assert_equal tag.articles_count, 2, "Articles_count not equal to articles quantity"
  end

  test "should automatically generate slug" do
    tag = create(:tag, name: "tag1", slug: "")
    assert_equal tag.slug, "tag1", "Did not generate slug automatically"
  end

  test "should replace non-character symbols with dashes" do
    tag = create(:tag, name: '!23this-is$%^a_testcatego23ry?')
    assert_equal tag.slug, "-23this-is---a-testcatego23ry-"
  end

  test "should translate slug in english" do
    tag = create(:tag, name: "Это пример категории")
    assert_equal tag.slug, "jeto-primer-kategorii"
  end
end
