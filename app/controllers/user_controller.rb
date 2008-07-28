class UserController < ApplicationController
  before_filter :restrict_if_not_logged_in, :only => [:edit, :update, :show, :index]
  before_filter :restrict_if_unauthorized, :only => [:edit, :update, :show]
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

  def save_password
    @user = User.find(params[:id])
    @user.reset_password_code = nil 
    @user.reset_password_code_until = nil 
		if @user.update_attributes(params[:user])
			flash[:success] = 'Password was successfully updated.'
			redirect_to(new_login_path)
		else
			render(:controller => :user, :action => :edit_password, :id => @user.id)
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

  def forgot_password
    user = User.find_by_email(params[:email])
    if (user) 
      user.reset_password_code_until = 1.day.from_now
      user.reset_password_code =  Digest::SHA1.hexdigest( "#{user.email}#{Time.now.to_s.split(//).sort_by {rand}.join}" )
      user.save!
      email = UserNotifier.deliver_forgot_password(user)
      render(:text => "<pre>" + email.encoded + "</pre>")
    else
      render(:text => "User not found: #{params[:email]}")
    end 
  end

  def reset_password
    user = User.find_by_reset_password_code(params[:id])
    if user &&  user.reset_password_code_until  && Time.now < user.reset_password_code_until 
      redirect_to(:controller => :user, :action => :edit_password, :id => user.id)
    else
      flash[:error] = 'Sorry, Request Expired!!!'
      redirect_to(new_login_path)
    end
  end
end
















