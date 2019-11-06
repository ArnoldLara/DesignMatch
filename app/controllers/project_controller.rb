class ProjectController < ApplicationController
  def all
    @admin_id = params['admin_id']
    @found_admin = Admin.find_by_id(@admin_id)
    @base_url = ENV['base_url']
    @admin_projects = []

    # Retrieves admin's projects
    if @found_admin != nil
      @pagy, @admin_projects = pagy(@found_admin.projects.order("created_at DESC"), items: 10)
    end

    render('project/all')
  end

  def new
    @project_new = Project.new
  end

  def create
    @project_new = Project.new(project_params)
    @admin_id = params[:admin_id].to_i
    @project_new.admin_id = @admin_id
    if @project_new.save
      redirect_to(:controller => 'project', :action => 'all', :admin_id => @admin_id)
    else
      render('new')
    end
  end

  def update
    @project_new = Project.find_by_id(params[:project_id].to_i)
  end

  def updateProject
    @project_id = params[:project_id].to_i
    @project_update = Project.find_by_id(@project_id)

    if @project_update.update(project_params)
      redirect_to(:controller => 'project', :action => 'all', :admin_id => @project_update.admin_id)
    else
      render('update')
    end

  end

  def view
    @project_view = Project.find_by_id(params['project_id'].to_i)
    if @project_view == nil
      @project_view = Project.new
    end
    @pagy, @designs = pagy(@project_view.designs.order("created_at DESC"), items: 10)
  end

  # A message would be fancy
  def delete
    @project_id = params['project_id']
    @admin_id = params[:admin_id].to_i

    Project.find_by_id(@project_id.to_i).destroy
    redirect_to(:controller => 'project', :action => 'all', :admin_id => @admin_id)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :price)
  end

end
