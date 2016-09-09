class Admin::ArticlesController < Admin::DashboardController
  def index
    filter = Hash.new
    if params[:commit] == 'Filter' && (params[:filter_category] != '' || params[:filter_status] != '')
      if !params[:filter_category].blank?
        filter.store(:category_fields, {:name => Category.find(params[:filter_category]).name})
      end
      if !params[:filter_status].blank?
        filter.store(:status, params[:filter_status])
      end
      @articles = Article.where(filter).order('created_at DESC').paginate(:page => params[:page], :per_page => 25 )
    else
      @articles = Article.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 25 )
    end
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
      update_date_of_publication(@article)
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

      update_date_of_publication(@article)

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
    params.require(:article).permit(:status, :title, :description, :content, :category_id)
  end

  def update_date_of_publication(article)
    if article.published?
      article.published_on = DateTime.now if article.published_on == nil
      article.save!
    elsif article.draft?
      article.published_on = nil
      article.save!
    end
  end
end
