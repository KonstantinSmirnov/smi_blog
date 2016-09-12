class Admin::AboutPagesController < AdminController

  def new
    @about_page = AboutPage.new
  end

  def create
    @about_page = AboutPage.new(about_page_params)

    if @about_page.save
      flash.now[:success] = "Item has been created"
      render 'edit'
    else
      render 'new'
    end
  end

  def edit
    @about_page = AboutPage.first
  end

  def update
    @about_page = AboutPage.first

    if @about_page.update_attributes(about_page_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  private

  def about_page_params
    params.require(:about_page).permit(:top_block_content, :about_foto)
  end
end
