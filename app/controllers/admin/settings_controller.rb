class Admin::SettingsController < AdminController
  def index
    @admin = current_admin
  end
    
end