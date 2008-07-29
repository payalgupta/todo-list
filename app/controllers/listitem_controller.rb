class ListitemController < ApplicationController
  before_filter :restrict_if_not_logged_in

  def new
    todolist=params[:todolist]
		render :update do |page|
			page.replace_html "new_listitem_#{todolist}", :partial => 'new'
		end
  end

  def add_listitem
    @todolist = Todolist.find(params[:listitem][:todolist_id])
    @listitem = Listitem.new(params[:listitem])
    if @todolist.completed_listitems << @listitem
      render :update do |page|
	      page.replace_html "new_listitem_#{@todolist.id}", ""
        page.insert_html :bottom, "todolist_incomplete_#{@todolist.id}", :partial => 'insert_this'
        page["block_listitem_#{@listitem.id}"].visual_effect :highlight, :duration => 5
        page.replace_html "message", ""
		  end
    else
      render :update do |page|
        page.replace_html "message", :partial => 'error'
      end
    end
  end

  def update
    @todolist = Todolist.find(params[:todolist_id])
    @listitem = Listitem.find(params[:id])
    @listitem.is_completed = @listitem.is_completed? ? 0 : 1
    if @listitem.update_attributes(params[:listitem])
		  render :update do |page|
        page["block_listitem_#{@listitem.id}"].visual_effect :blind_up
        if @listitem.is_completed?
          page.insert_html :top, "todolist_complete_#{@todolist.id}", :partial => 'insert_this'
        else
          page.insert_html :bottom, "todolist_incomplete_#{@todolist.id}", :partial => 'insert_this'
        end
        page["block_listitem_#{@listitem.id}"].visual_effect :highlight, :duration => 5
		  end
    end
  end

end
