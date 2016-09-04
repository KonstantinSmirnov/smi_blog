class Admin::ArticlesController < Admin::DashboardController
  def index
    @articles = Article.all.reverse
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Article has been created"
      redirect_to admin_articles_path
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :content)
  end
end
