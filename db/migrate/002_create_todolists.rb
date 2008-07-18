class CreateTodolists < ActiveRecord::Migration
  def self.up
    create_table :todolists do |t|
      t.string :title
      t.text :description
      t.string :user_id
      t.boolean :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :todolists
  end
end
