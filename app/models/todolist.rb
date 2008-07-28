class Todolist < ActiveRecord::Base
	belongs_to :user
	has_many :completed_listitems, :conditions => {:is_completed => 1}, :class_name => 'Listitem'
	has_many :notcompleted_listitems, :conditions => {:is_completed => 0}, :class_name => 'Listitem'
	validates_presence_of	:title
	validates_uniqueness_of	:title, :scope => "user_id"
end
