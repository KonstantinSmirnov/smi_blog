class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :load_social_icons

  private

  def load_social_icons
    @social_icons = Social.all
  end
end
