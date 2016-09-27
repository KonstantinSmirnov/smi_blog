class StaticPagesController < ApplicationController
  layout nil
  
  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end
  
  def sitemap
    @articles = Article.published
    respond_to do |format|
      format.xml
    end
  end
end
