class UserController < ApplicationController
  before_filter :authorize, :only => [:index, :show]
  before_filter :restrict_if_logged_in, :except => [:index, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
		if @user.save
      flash[:success] = "User #{@user.username} was successfully created."
      redirect_to(new_login_path)
    else
      render(:action => :new)
    end
  end

  def index
    @users = User.find(:all)  
  end

  def show
    @user = User.find(params[:id])  
  end

	def check_username_availability
		if params[:user][:username].blank?
			message = "Username should not be blank."
      color = '#FF0000'
		elsif
		  if User.find_by_username(params[:user][:username])
		      message = "Username not available"
          color = '#FF0000'
		  else
		      message = "Username available."
          color = '#00FF00'
		  end
		end 
   		render :update do |page|
			page.replace_html 'availability_msg', "<font color='#{color}'>#{message}</font>"
		end
  end
end
