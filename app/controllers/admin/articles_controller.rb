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
      @articles = Article.where(:status.nin => [:removed]).order('created_at DESC').paginate(:page => params[:page], :per_page => 25 )
    end
  end

  def show
    @article = Article.find_by(:slug => params[:id])
    @random_articles = Article.random(3)
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
      @article.update_publication_date
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
    if params[:article][:tags_attributes]
      params[:article][:tags_attributes].each do |key, values|
      if !values["slug"]
        if Tag.where(:slug => Translit.convert(values["name"], :english).downcase.gsub(/[^0-9a-z]/i, '-')).exists?
          @article.tags << Tag.find_by(:slug => Translit.convert(values["name"], :english).downcase.gsub(/[^0-9a-z]/i, '-'))
          params[:article][:tags_attributes].delete key
        else
          # This is a new tag
        end
      end

      #remove empty tag
      params[:article][:tags_attributes].delete key if values["name"].blank?

      if values["_destroy"] == "1" && values["slug"]
        tag = Tag.find_by(:slug => values["slug"])
        if tag.articles.count > 1
          tag.articles.delete(@article)
          tag.save
          @article.tags.delete(tag)
          params[:article][:tags_attributes].delete key
          # tag link removed
        else
          # tag completely removed
        end
      end
    end
    end
    if @article.update_attributes(article_params)
      @article.update_publication_date

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

  def add_tag
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @article = Article.find_by(:slug => params[:id])
    if @article.removed?
      @article.destroy
      flash[:success] = "Article was deleted"
      redirect_to admin_articles_path
    else
      @article.removed!
      @article.update_publication_date
      flash[:success] = "Article was moved to trash"
      redirect_to admin_articles_path
    end
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
                                    :images_attributes => [:id, :description, :image, :primary_image, :_destroy],
                                    :tags_attributes => [:id, :name, :slug, :_destroy]
                                    )
  end

end
