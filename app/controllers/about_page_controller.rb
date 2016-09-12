class AboutPageController < ApplicationController
  def show
    @about = AboutPage.first
  end
end
