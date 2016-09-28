class Admin::CommentsController < AdminController
  def index
    @comments = Comment.order(created_at: :desc).paginate(:page => params[:page], :per_page => 20 )
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment was deleted"
    redirect_to admin_comments_path
  end
  
end