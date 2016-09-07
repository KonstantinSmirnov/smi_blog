class Admin::CategoriesController < Admin::DashboardController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "category has been created"
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "Category was deleted"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end