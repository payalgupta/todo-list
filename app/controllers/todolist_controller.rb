class TodolistController < ApplicationController
  before_filter :restrict_if_not_logged_in
  def new
    @todolist = Todolist.new
  end

  def show
  end

  def create
    @todolist = Todolist.new(params[:todolist])
    @todolist.user = current_user
		if @todolist.save
      flash[:success] = "Todo #{@todolist.title} was successfully created."
      redirect_to(todolist_index_path)
    else
      render(:action => 'new')
    end
  end
end
