class ListitemController < ApplicationController

  def add_listitem
    p params[:listitem][:todolist_id]
    todolist = Todolist.find(params[:listitem][:todolist_id])
    listitem = Listitem.new(params[:listitem])
    todolist.listitems << listitem
    redirect_to(:action => :list_all, :controller => :todolist)
  end

end
