class LoginController < ApplicationController
  before_filter :authorize, :except => [:login, :new, :create, :check_username_availability]
  def index
    @users = User.find(:all)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
		if @user.save
      flash[:success] = "User #{@user.username} was successfully created."
      redirect_to(:action => :login, :controller => :login)
    else
      render(:action => :new)
    end
  end

	def check_username_availability
		if params[:user][:username].blank?
			message = "Username should not be blank."
		else
		  if User.find_by_username(params[:user][:username])
		      message = "Username not available"
		  else
		      message = "Username available."
		  end
		end 
   		render :update do |page|
			page.replace_html 'availability_msg', message
		end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
				session[:user_id] = user.id
				redirect_to(:action => "index", :controller => :todolist )
      else
        flash.now[:error] = "Enter valid username/password"
	      render(:action => "login" )
      end
    end 
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully Logged out"
    redirect_to(:action => "login" )	  
  end

end
