class Admin::AboutsController < Admin::DashboardController

  def new
    @about = About.new
  end

  def create
    @about = About.new(about_params)

    if @about.save
      flash[:success] = "Item has been created"
      redirect_to admin_abouts_path
    else
      render 'new'
    end
  end

  def edit
    @about = About.first
  end

  def update
    @about = About.first

    if @about.update_attributes(about_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  private

  def about_params
    params.require(:about).permit(:top_block_content)
  end
end
