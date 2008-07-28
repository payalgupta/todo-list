# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
	helper_method :current_user, :logged_in?

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '707a4952295d1c5b3fb29c6e90697724'

  def restrict_if_not_logged_in
    if current_user.blank?
      flash[:notice] = "Please log in"
      redirect_to(new_login_path)
    end
  end

  def restrict_if_unauthorized
		if requested_user == nil
			flash[:error] = "InValid Action!!!"
	    redirect_to(todolist_index_path)
		else
			if current_user != requested_user
				flash[:error] = "InValid Action!!!"
			  redirect_to(todolist_index_path)
			end
		end
  end

  def restrict_if_logged_in
    if logged_in?
      redirect_to(todolist_index_path)
    end
  end

	def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

	def requested_user
    @requested_user ||= User.find(params[:id])
  end

	def logged_in?
	 current_user != nil
	end
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
