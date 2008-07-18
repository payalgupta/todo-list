class TodolistController < ApplicationController
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
		if @todolist.save
      flash[:success] = "Todo #{@todolist.title} was successfully created."
      redirect_to(:action => :index, :controller => :todolist)
    else
      render(:action => :new)
    end

  end
end
