class HomePageController < ApplicationController
  def show
    @home_page = HomePage.first
  end
end
