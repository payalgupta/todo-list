class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.date :birthdate
      t.string :sex
      t.boolean :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
