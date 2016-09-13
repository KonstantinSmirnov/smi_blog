class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id]) 
    @new_comment = @article.comments.new(comment_params)
    respond_to do |format|
      if @new_comment.save
        flash.now[:success] = "Comment have been added"
        format.js { render 'create_success.js.erb' }
      else
        flash.now[:danger] = "Comment was not added"
        format.js { render 'create_fail.js.erb' }
      end
    end
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:author_name, :text)
  end
end