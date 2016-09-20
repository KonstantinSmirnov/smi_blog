class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :initialize_app

  private

  def initialize_app
    @social_icons_list = Social.all
    @common_settings = Setting.first
  end
end
