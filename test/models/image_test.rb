require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  def setup
    @article = create(:article)
  end

  test "should be saved with proper data" do
    image = build(:image, article: @article)
    assert image.save, "Not saved with proper data."
  end

  test "should not be saved without description" do
    image = build(:image, description: "", article: @article)
    assert_not image.save, "Saved without description."
  end

  test "should not be saved without image" do
    image = build(:image, image_uid: "", image_name: "", article: @article)
    assert_not image.save, "Saved without image."
  end

  test "should not be saved without article" do
    image = build(:image, article: "")
    assert_not image.save, "Saved without article."
  end

  test "should not be saved with image of improper format" do
    proper_formats = [
      :jpg => 'http://wiki.voip.ms/w/images/thumb/6/65/Download.jpg/50px-Download.jpg',
      :png => 'https://avatanplus.com/files/resources/mid/57a167787066b1564e7c2e8c.png',
      :git => 'http://cdn-img.easyicon.net/png/11090/1109058.gif'
      ]
    improper_formats = {
      :txt => 'http://smiplay.com/robots.txt',
      :html => 'https://c-t-s.ru/ext/xml.html',
      :php => 'http://www.simplehtmlguide.com/whatishtml.php',
      :xml => 'http://www.w3schools.com/xml/note.xml'
    }
    proper_formats.each do |key, image_url|
      image = build(:image, article: @article)
      image.image_url = image_url
      assert image.save, "Not saved with proper image format #{key}"
    end
    improper_formats.each do |key, image_url|
      image = build(:image, article: @article)
      image.image_url = image_url
      assert_not image.save, "Saved with improper image format #{key}"
    end
  end

  test "should have primary_image = false by default" do
    image = build(:image, article: @article)
    assert_equal image.primary_image, false, "Does not have primary_image = false by default."
  end

  test "should give list of primary images" do
    primary_image_1 = create(:image, article: @article, primary_image: true)
    primary_image_2 = create(:image, article: @article, primary_image: true)
    image = build(:image, article: @article)
    count = @article.images.primary_images.count
    assert_equal count, 2, "Show not only primary images if requested primary images."
  end

end
