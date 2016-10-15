require 'test_helper'

class HomePageTest < ActiveSupport::TestCase

  test "should be saved with proper data" do
    home_page = build(:home_page)
    assert home_page.save, "Not saved with correct data."
  end

  test "should not be saved with title_backgroung of improper format" do
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
      home_page = build(:home_page)
      home_page.title_backgroung_url = image_url
      assert home_page.save, "Not saved with proper image format #{key}"
    end
    improper_formats.each do |key, image_url|
      home_page = build(:home_page)
      home_page.title_backgroung_url = image_url
      assert_not home_page.save, "Saved with improper image format #{key}"
    end
  end

  test "should not be saved without title" do
    home_page = build(:home_page, title: "")
    assert_not home_page.save, "Saved without title."
  end

  test "should not be saved without about_title" do
    home_page = build(:home_page, about_title: "")
    assert_not home_page.save, "Saved without about_title."
  end

  test "should not be saved without about_content" do
    home_page = build(:home_page, about_content: "")
    assert_not home_page.save, "Saved without about_content."
  end

  test "shoud not be saved without services_title" do
    home_page = build(:home_page, services_title: "")
    assert_not home_page.save, "Saved without services_title."
  end

  # embedded servces

  test "should not be saved without projects_title" do
    home_page = build(:home_page, projects_title: "")
    assert_not home_page.save, "Saved without projects_title"
  end

end
