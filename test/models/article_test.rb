require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  test "should not save empty article" do
    article = Article.new(:slug => "test2")
    assert_not article.save, "Saved the article without :title, :description, :keywords, :content"
  end

  test "should not save with empty title" do
    article = build(:article, title: "")
    assert_not article.save, "Saved with empty title"
  end

  test "should not save article without description" do
    article = build(:article, description: "")
    assert_not article.save, "Saved with empty description"  end

  test "should not save article without keywords" do
    article = build(:article, keywords: "")
    assert_not article.save, "Saved with empty keywords"
  end

  test "should not save article without content" do
    article = build(:article, content: "")
    assert_not article.save, "Saved with empty content"
  end

  test "should not save with not unique slug" do
    article1 = create(:article, slug: "unique-slug", category: Category.first)
    article2 = build(:article, slug: "unique-slug")
    assert_not article2.save, "Saved with used slug. Slug should be unique!"
  end

  test "should replace non-character symbols with dashes" do
    article = create(:article, slug: '!23this-is$%^a_testcatego23ry?', category: Category.first)
    assert_equal article.slug, "-23this-is---a-testcatego23ry-"
  end

  test "should translate slug in english" do
    article = create(:article, slug: "Это пример категории", category: Category.first)
    assert_equal article.slug, "jeto-primer-kategorii"
  end

  test "default views should be 0" do
    article = create(:article, slug: "test-views")
    assert article.views == 0, "Default views quantity is not zero."
  end

  test "should have status :draft after creation" do
    article = create(:article, slug: "test-status")
    assert_equal article.status, :draft, "Default status is not :draft."
  end

  test "should have status :published after publication" do
    article = create(:article, slug: "test-publication")
    article.published!
    assert_equal article.status, :published, "Did not change status to :published"
  end

  test "should have status :draft after unpublication" do
    article = create(:article, slug: "test-publication", status: :published)
    article.draft!
    assert_equal article.status, :draft, "Did not change status to :draft"
  end

  test "should update publication date after changing status to published" do
    article = create(:article, slug: "test-publication")
    article.published!
    article.update_publication_date
    assert article.published_on, "Has not publication date"
  end

  test "should remove publication date after changing status to draft" do
    article = create(:article, slug: "test-publication", status: :published)
    article.draft!
    article.update_publication_date
    assert_not article.published_on, "Has publication date"
  end

  test "can get random articles" do
    10.times do |n|
      create(:article, slug: "#{n}", status: :published, category: Category.first)
    end
    quantity = rand(1..10)
    random_count = Article.random(quantity).to_a.length
    assert_equal random_count, quantity
  end

  test "can get random article only from published" do
    10.times do |n|
      create(:article, slug: "#{n}", status: :draft, category: Category.first)
    end
    quantity = rand(1..10)
    random_count = Article.random(quantity).to_a.length
    assert_equal random_count, 0
  end

  test "should be able to have comments" do
    article = create(:article, slug: "test-comments")
    before = article.comments.count
    comment = create(:comment, article: article)
    after = article.comments.count
    assert_equal after, (before + 1), "Has comments quantity differs from 1"
  end

  test "should be destroyed with its comments" do
    article = create(:article, slug: "test-comments")
    comment = create(:comment, article: article)
    before = Comment.count
    article.destroy
    after = Comment.count
    assert_equal before - after, 1, "Comments were not destroyed with article."
  end

  # test "should be destroyed with its images" do
  #
  # end
  #
  # test "should be destroyed with its tags" do
  #
  # end


end
