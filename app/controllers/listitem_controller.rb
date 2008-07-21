class ListitemController < ApplicationController
  before_filter :authorize
  def add_listitem
    p params[:listitem][:todolist_id]
    todolist = Todolist.find(params[:listitem][:todolist_id])
    listitem = Listitem.new(params[:listitem])
    todolist.listitems << listitem
    redirect_to(:controller => 'todolist', :action => 'list_all')
  end

end
