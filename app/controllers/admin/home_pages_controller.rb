class Admin::HomePagesController < Admin::DashboardController

  def new
    @home_page = HomePage.new
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

  private

  def home_page_params
    params.require(:home_page).permit(:title, :title_background, :about)
  end
end
