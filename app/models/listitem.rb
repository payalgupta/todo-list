class Listitem < ActiveRecord::Base
	belongs_to :todolist
	validates_presence_of	:listitem
	validates_uniqueness_of	:listitem, :scope => "todolist_id"
end
