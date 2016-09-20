class Admin::SettingsController < AdminController
  def new
    @settings = Setting.new
    @admin = current_admin
  end

  def create
    @settings = Setting.new(settings_params)
    @admin = current_admin

    if @settings.save
      flash.now[:success] = "Item has been created"
      render 'edit'
    else
      render 'new'
    end
  end

  def edit
    @settings = Setting.first
    @admin = current_admin
  end

  def update
    @settings = Setting.first
    @admin = current_admin

    if @settings.update_attributes(settings_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  private

  def settings_params
    params.require(:setting).permit(
                            :website_title,
                            :default_description,
                            :default_keywords,
                            :twitter_share_via_account
                            )
  end

end
