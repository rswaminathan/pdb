class AddResetToUsers < ActiveRecord::Migration
  def self.up
     add_column :users, :reset, :string
  end

  def self.down
    remove_column :users, :reset
  end
end
