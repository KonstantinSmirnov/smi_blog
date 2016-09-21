class Admin::ArticlesController < AdminController

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
    @article = Article.find_by(:slug => params[:id])
    @comments = @article.comments.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10 )
    @new_comment = @article.comments.build
    cookies[:opened_article_id] = params[:id]
    cookies[:article_opened_at] = Time.now.to_i
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      update_date_of_publication(@article)
      flash[:success] = "Article has been created"
      redirect_to edit_admin_article_path(@article)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find_by(:slug => params[:id])
  end

  def update
    @article = Article.find_by(:slug => params[:id])
    if @article.update_attributes(article_params)
      update_date_of_publication(@article)

      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def add_image
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @article = Article.find_by(:slug => params[:id])
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:status,
                                    :slug,
                                    :title,
                                    :description,
                                    :keywords,
                                    :content,
                                    :category_id,
                                    :images_attributes => [:id, :description, :image, :primary_image, :_destroy]
                                    )
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
