class StaticPagesController < ApplicationController
  def robots
    respond_to :txt
    expires_in 6.hours, public: true
  end
end
