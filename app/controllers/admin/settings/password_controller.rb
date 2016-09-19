class Admin::Settings::PasswordController < Admin::SettingsController

before_action :authenticate_admin!

  def update
    @admin = Admin.find(current_admin.id)
    if @admin.valid_password?(params[:admin][:current_password])
      if @admin.update(admin_params)
        # Sign in the admin by passing validation in case their password changed
        sign_in @admin, :bypass => true
        flash[:success] = "Password has been updated!"
        redirect_to_settings_path
      else
        flash[:danger] = "Password was not updated, new password and password confirmation should match."
        redirect_to_settings_path
      end
    else
      flash[:danger] = "Password is incorrect. Please enter correct password."
      redirect_to_settings_path
    end
  end

  private

  def admin_params
    # NOTE: Using `strong_parameters` gem
    params.require(:admin).permit(:password, :password_confirmation)
  end

  def redirect_to_settings_path
    if Setting.first.persisted?
      redirect_to edit_admin_setting_path
    else
      redirect_to new_admin_setting_path
    end
  end

end
