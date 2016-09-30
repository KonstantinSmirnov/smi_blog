class Admin::TagsController < AdminController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:success] = "Tag has been created"
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find_by(:slug => params[:id])
  end

  def update
    @tag = Tag.find_by(:slug => params[:id])

    if @tag.update_attributes(tag_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find_by(:slug => params[:id])
    @tag.destroy
    flash[:success] = "tag was deleted"
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end