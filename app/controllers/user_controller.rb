class UserController < ApplicationController
  before_filter :authorize, :except => [:new, :create, :check_username_availability, :sent_mail]
  before_filter :authorize_user, :only => [:edit, :update, :show]
  before_filter :restrict_if_logged_in, :only => [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @password = params[:user][:password]
		if @user.save
      email = SignupMailer.create_confirm(@user, @password)
      render(:text => "<pre>" + email.encoded + "</pre>" )
    else
      render(:action => :new)
    end
  end


  def index

  end

  def show
    @user = User.find(params[:id])  
  end

  def edit
    @user = User.find(params[:id])  
  end

  def update
    @user = User.find(params[:id]) 
		if @user.update_attributes(params[:user])
			flash[:success] = 'User was successfully updated.'
			redirect_to(user_path(@user))
		else
			render(:controller => :user, :action => :edit, :id => @user.id)
		end
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
