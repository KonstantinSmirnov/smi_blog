class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id]) 
    @new_comment = @article.comments.new(comment_params)
    puts "!!!!! Cookies!"
    puts cookies[:opened_article_id]
    puts cookies[:article_opened_at]
    puts Time.now.to_i - cookies[:article_opened_at].to_i
    if cookies[:opened_article_id] == params[:article_id] && ( Time.now.to_i - cookies[:article_opened_at].to_i) > 15
      respond_to do |format|
        if @new_comment.save
          format.js { render 'create_success.js.erb' }
        else
          format.js { render 'create_fail.js.erb', :locals => { :text => "Comment was not created. Please check if all fields filled correct." } }
        end
      end
    else
      respond_to do |format|
        format.js { render 'create_fail.js.erb', :locals => { :text => "Antispam filter requires to wait #{15 - Time.now.to_i + cookies[:article_opened_at].to_i} more seconds after Article is opened." } }
      end
    end
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:author_name, :text)
  end
end