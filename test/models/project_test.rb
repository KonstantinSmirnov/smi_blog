require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @home_page = HomePage.first
  end

  test "should be saved with proper data" do
    project = build(:project, home_page: @home_page)
    assert project.save, "Not saved with proper data."
  end

  test "should not be saved without title" do
    project = build(:project, title: "", home_page: @home_page)
    assert_not project.save, "Saved without title."
  end

  test "should not be saved without image" do
    project = build(:project, image_uid: "", image_name: "", home_page: @home_page)
    assert_not project.save, "Saved without image."
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
      project = build(:project, home_page: @home_page)
      project.image_url = image_url
      assert project.save, "Not saved with proper image format #{key}"
    end
    improper_formats.each do |key, image_url|
      project = build(:project, home_page: @home_page)
      project.image_url = image_url
      assert_not project.save, "Saved with improper image format #{key}"
    end
  end

end
