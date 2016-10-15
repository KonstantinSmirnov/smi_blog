require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @article = create(:article)
  end

  test "should not be created without author name" do
    comment = build(:comment, author_name: "", article: @article)
    assert_not comment.save, "Saved without author name"
  end

  test "should not be created without text" do
    comment = build(:comment, text: "", article: @article)
    assert_not comment.save, "Saved without text"
  end

  test "should not be created with author name more than 20 symbols" do
    comment = build(:comment, author_name: "a"*25, article: @article)
    assert_not comment.save, "Saved with author_name longer than 20 symbols"
  end

  test "should not be created with text less than 10 symbols" do
    comment = build(:comment, text: "a"*3, article: @article)
    assert_not comment.save, "Save with text less than 10 symbols"
  end

  test "should not be created with text more than 140 symbols" do
    comment = build(:comment, text: "a"*145, article: @article)
    assert_not comment.save, "Saved with text more than 140 symbols."
  end

  test "should be created with author name and text" do
    comment = build(:comment, article: @article)
    assert comment.save, "Not saved with proper data."
  end

  test "should have status :fresh after creation" do
    comment = create(:comment, article: @article)
    assert_equal comment.status, :fresh, "Does not have status :fresh for new comments"
  end

  test "can be banned" do
    comment = create(:comment, article: @article)
    comment.banned!
    assert_equal comment.status, :banned, "Does not have status :banned if banned"
  end

  test "can be approved" do
    comment = create(:comment, article: @article)
    comment.approved!
    assert_equal comment.status, :approved, "Does not have status :approved if approved"
  end

end
