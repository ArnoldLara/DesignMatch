class HomeController < ApplicationController
  def home
  end

  def register
    @admin = Admin.new
    render('home/register')
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.company = @admin.company.downcase
    @company = Company.find_by_name(@admin.company)

    if @company == nil
      Company.create(:name => @admin.company, :last_index => 1)
      @admin.url = "#{@admin.company}.#{1}"
    else
      @company.update(:last_index => @company.last_index + 1)
      @admin.url = "#{@admin.company}.#{@company.last_index + 1}"
    end

    if @admin.save
      @admin_session = @admin
      @admin_session.password = ""
      session[:admin] = @admin_session
      redirect_to(:controller => 'project', :action => 'all', :admin_id => @admin.id)
    end

  end

  def logIn
    @admin = Admin.new
    render('home/logIn')
  end

  def do_log_in
    @admin = Admin.new(admin_params)
    @found = Admin.find_by(:email => @admin.email, :password => @admin.password)

    if @found != nil
      @admin_session = @found
      @admin_session.password = ""
      session[:admin] = @admin_session
      redirect_to(:controller => 'project', :action => 'all', :admin_id => @found.id)
    end
  end

  def redirect_if_necessary
    if session[:admin] != nil
      @admin = session[:admin]
      redirect_to(:controller => 'project', :action => 'all', :admin_id => @admin["id"])
    end
  end

  private
    def admin_params
      params.require(:admin).permit(:company, :email, :password)
    end
end
