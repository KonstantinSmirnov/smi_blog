class Admin::ProjectsController < AdminController
  def index
    @projects = Project.all
  end

  def new
    @home_page = HomePage.first
    @project = @home_page.projects.build
  end

  def create
    @home_page = HomePage.first
    @project = @home_page.projects.create(project_params)

    if @project.save
      flash[:success] = "Project has been created"
      redirect_to admin_projects_path
    else
      render 'new'
    end
  end

  def edit
    @home_page = HomePage.first
    @project = @home_page.projects.find(params[:id])
  end

  def update
    @home_page = HomePage.first
    @project = @home_page.projects.find(params[:id])

    if @project.update_attributes(project_params)
      flash.now[:success] = "Changes were saved"
      render 'edit'
    else
      render 'edit'
    end
  end

  def destroy
    @home_page = HomePage.first
    @project = @home_page.projects.find(params[:id])
    
    @project.destroy
    flash[:success] = "Project was deleted"
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :image)
  end
end