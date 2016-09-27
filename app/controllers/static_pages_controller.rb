class StaticPagesController < ApplicationController
  layout nil
  
  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end
  
  def sitemap
    @home_page = HomePage.first
    @about_page = AboutPage.first
    @articles = Article.published
    respond_to do |format|
      format.xml
    end
  end
end
