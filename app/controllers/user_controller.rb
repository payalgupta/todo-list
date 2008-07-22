class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p "test"
    @user = User.new(params[:user])
		if @user.save
      flash[:success] = "User #{@user.username} was successfully created."
      redirect_to(login_path)
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
          color = {:startcolor => "#FF0000"}
		  else
		      message = "Username available."
          color = {:startcolor => "#00FF00"}
		  end
		end 
   		render :update do |page|
			page.replace_html 'availability_msg', message
      page['availability_msg'].visual_effect :highlight, color
		end
  end
end
