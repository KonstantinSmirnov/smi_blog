class Admin::DashboardController < AdminController
  def index
    @total_views = Article.all.sum(:views)
  end
end
