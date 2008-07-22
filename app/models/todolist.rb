class Todolist < ActiveRecord::Base
	belongs_to :user
	has_many :listitems
	validates_presence_of	:title, :description
	validates_uniqueness_of	:title, :scope => "user_id"
  def incompleteitems=(todolist)
    @todolist = Todolist.find(todolist)
    listitems = @todolist.listitems.find_by_is_completed('1')
    listitems
  end
end
