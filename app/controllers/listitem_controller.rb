class ListitemController < ApplicationController
  before_filter :authorize

  def new
    todolist=params[:todolist]
		render :update do |page|
			page.insert_html :bottom, "todolist_#{todolist}", :partial => 'new'
		end
  end

  def add_listitem
    todolist = Todolist.find(params[:listitem][:todolist_id])
    listitem = Listitem.new(params[:listitem])
    if todolist.listitems << listitem
      redirect_to(todolist_index_path)
    else
      render(:action => 'index')
    end
  end

end
