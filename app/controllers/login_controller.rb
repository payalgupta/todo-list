class LoginController < ApplicationController
  before_filter :restrict_if_logged_in, :except => :destroy
  def new
  end

  def create
    session[:user_id] = nil
    user = User.authenticate(params[:username], params[:password])
    if user
		  session[:user_id] = user.id
		  redirect_to(todolist_index_path)
    else
      flash.now[:notice] = "Enter valid username/password"
      render(:action => 'new')
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully Logged out"
    redirect_to(new_login_path)	  
  end
end
