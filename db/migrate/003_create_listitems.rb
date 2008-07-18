class CreateListitems < ActiveRecord::Migration
  def self.up
    create_table :listitems do |t|
      t.text :listitem
      t.string :todolist_id
      t.boolean :is_completed, :default => 0
      t.boolean :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :listitems
  end
end
