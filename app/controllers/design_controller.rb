require 'aws-sdk-sqs'

class DesignController < ApplicationController

  def all
    @url_id = params[:format]
    @company_name = params[:admin_url]
    @admin_url = "#{@company_name}.#{@url_id}"
    @pagy, @projects = pagy(findProjectsByUrl(@admin_url), items: 10)
  end

  def view
  end

  def new
    @design = Design.new
    @project = Project.find_by_id(params[:project_id].to_i)
  end

  def create
    @design = Design.new(design_params)
    @project_id = params[:project_id]
    @project = Project.find_by_id(@project_id)
    @design.project_id = @project_id

    if @design.save
      Aws::SQS::Client
          .new(region: 'us-east-1',
               access_key_id: ENV['KEY_OSCAR'],
               secret_access_key: ENV['SECRET_OSCAR'])
          .send_message(queue_url: 'https://sqs.us-east-1.amazonaws.com/050073096789/design_match_queue', message_body: @design.id.to_s)
      redirect_to(:controller => 'design', :action => 'all', :admin_url => @project.admin.url)
    else
      render('new')
    end

  end


  private
    def findProjectsByUrl(url)
    if url == nil || url == '' || Admin.find_by_url(url) == nil
      []
    else
      Admin.find_by_url(url).projects.order("created_at DESC")
    end

    end
  
    def design_params
      params.require(:design).permit(:designer_name, :designer_last_name, :designer_email, :price, :original_design)
    end
end
