class Admin::ImagesController < AdminController
  def index
    @images = Image.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 25 )
  end

end
