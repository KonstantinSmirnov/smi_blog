class Admin::SocialsController < AdminController
  def index
    @socials = Social.all
  end

  def new
    @social = Social.new
  end

  def create
    @social = Social.new(social_params)

    if @social.save
      flash[:success] = "Item has been created"
      redirect_to admin_socials_path
    else
      render 'new'
    end
  end

  def edit
    @social = Social.find(params[:id])
  end

  def update
    @social = Social.find(params[:id])

    if @social.update_attributes(social_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @social = Social.find(params[:id])
    @social.destroy
    flash[:success] = "Item was deleted"
    redirect_to admin_socials_path
  end

  private

  def social_params
    params.require(:social).permit(:icon_text, :link)
  end
end
