class Listitem < ActiveRecord::Base
	belongs_to :todolist
	validates_presence_of	:listitem
end
