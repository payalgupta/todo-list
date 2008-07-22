class LoginController < ApplicationController

  def show
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
				session[:user_id] = user.id
				redirect_to(todolist_path)
      else
        flash.now[:error] = "Enter valid username/password"
	      render(:action => 'show')
      end
    end 
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully Logged out"
    redirect_to(:action => 'show')	  
  end
end
