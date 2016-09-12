class Admin::HomePagesController < AdminController

  def new
    @home_page = HomePage.new
    @home_page.services.build
  end

  def create
    @home_page = HomePage.new(home_page_params)

    if @home_page.save
      flash.now[:success] = "Item has been created"
      render 'edit'
    else
      render 'new'
    end
  end

  def edit
    @home_page = HomePage.first
  end

  def update
    @home_page = HomePage.first
    if @home_page.update_attributes(home_page_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def add_service
    respond_to do |format|
        format.js
    end
  end

  private

  def home_page_params
    params.require(:home_page).permit(
          :title,
          :title_backgroung,
          :about_title,
          :about_content,
          :services_title,
          :projects_title,
          :services_attributes => [:id, :icon, :title, :content, :_destroy],
    )
  end
end
