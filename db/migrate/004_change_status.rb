class ChangeStatus < ActiveRecord::Migration
  def self.up
    change_column(:users, :status, :integer, :default => 0)
    change_column(:todolists, :status, :integer, :default => 0)
    change_column(:listitems, :status, :integer, :default => 0)
  end

  def self.down
    change_column(:users, :status, :boolean, :default => 0)
    change_column(:todolists, :status, :boolean, :default => 0)
    change_column(:listitems, :status, :boolean, :default => 0)
  end
end
