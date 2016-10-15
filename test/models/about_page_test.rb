require 'test_helper'

class AboutPageTest < ActiveSupport::TestCase
  test "shoudl not be saved without content" do
    about_page = build(:about_page, content: "")
    assert_not about_page.save, "Save without content."
  end

  test "should not be saved without image" do
    about_page = build(:about_page, image_name: "", image_uid: "")
    assert_not about_page.save, "Save without image."
  end

  test "should be saved with proper content and image" do
    about_page = build(:about_page)
    assert about_page.save
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
      about_page = build(:about_page)
      about_page.image_url = image_url
      assert about_page.save, "Not saved with proper image format #{key}"
    end
    improper_formats.each do |key, image_url|
      about_page = build(:about_page)
      about_page.image_url = image_url
      assert_not about_page.save, "Saved with improper image format #{key}"
    end
  end
end
