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

    if @category.name != "(no category)"
      if @category.update_attributes(category_params)
        flash.now[:success] = "Changes were saved"
        render 'edit'
      else
        render 'edit'
      end
    else
      flash.now[:danger] = "Impossible to update (no category)!"
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.name != "(no category)"
      @articles = Article.where(category: @category)
      @default_category = Category.where(name: '(no category)')
      if @category.destroy
        @articles.map {|a| a.update_attribute(:category, Category.where(name: '(no category)').first)}
        flash[:success] = "Category was deleted"
        redirect_to admin_categories_path
      else
        flash[:danger] = "Category can not be deleted!"
        redirect_to admin_categories_path
      end
    else
      flash[:danger] = "Impossible to delete (no category)!"
      redirect_to admin_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :articles_count)
  end
end
