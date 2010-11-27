class AddAbouttoUser < ActiveRecord::Migration
  def self.up
  add_column :users, :about, :body
  end

  def self.down
  remove_column :users, :about, :body
  end
end
