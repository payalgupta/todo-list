class TodolistController < ApplicationController
  before_filter :authorize
  def new
    @todolist = Todolist.new
  end

  def list_all
    @todolists = Todolist.find(:all)
  end

  def my_todolist
    @todolists = Todolist.find_by_user_id(current_user.id)
  end

  def create
    @todolist = Todolist.new(params[:todolist])
    @todolist.user = current_user
		if @todolist.save
      flash[:success] = "Todo #{@todolist.title} was successfully created."
      redirect_to(:controller => 'todolist', :action => 'index')
    else
      render(:action => 'new')
    end
  end
end
