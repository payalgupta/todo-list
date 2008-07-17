class LoginController < ApplicationController
  def index
    @users = User.find(:all)
  end

  def new
    @sex = ["Male", "Female"]
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
		if @user.save
      flash[:success] = "User #{@user.username} was successfully created."
      redirect_to(:action => :index, :controller => :login)
    else
      render(:action => :new)
    end
  end

	def check_username_availability
		@message = nil
		@username = params[:user][:username]
		if @username.blank?
			@message = "Username should not be blank."
		else
		  if User.find_by_username(@username)
		      @message = "Username not available"
		  else
		      @message = "Username available."
		  end
		end 
   		render :update do |page|
			page.replace_html 'testdiv', :partial => 'check_availability'
		end
  end

  def login
  end

end
