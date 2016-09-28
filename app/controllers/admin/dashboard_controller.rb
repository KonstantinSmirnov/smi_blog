class Admin::DashboardController < AdminController
  def index
    @total_views = Article.all.sum(:views)
    @total_comments = Comment.count
  end
end
