class LoginController < ApplicationController
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
      redirect_to(:action => :index, :controller => :login)
    else
      render(:action => :new)
    end
  end

  def login
  end

end
