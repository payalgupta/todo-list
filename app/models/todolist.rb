class Todolist < ActiveRecord::Base
	belongs_to :user
	has_many :listitems
	validates_presence_of	:title
	validates_uniqueness_of	:title, :scope => "user_id"
end
