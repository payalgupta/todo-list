class ListitemController < ApplicationController
  before_filter :restrict_if_not_logged_in

  def new
    todolist=params[:todolist]
		render :update do |page|
			page.replace_html "new_listitem_#{todolist}", :partial => 'new'
		end
  end


  def add_listitem
    todolist = Todolist.find(params[:listitem][:todolist_id])
    listitem = Listitem.new(params[:listitem])
    todolist.listitems << listitem
    render :update do |page|
	    page.remove "new_listitem_#{todolist.id}"
      page.insert_html :bottom, "todolist_complete_#{todolist.id}", "<input type='checkbox' id='not_complete_#{listitem.id}'>#{listitem.listitem}"
		end
  end

end
