class AddSchooltoUsers < ActiveRecord::Migration
  def self.up
  add_column :users, :institution, :string
  add_column :users, :occupation, :string
  add_column :users, :year, :string
  end

  def self.down
  remove_column :users, :institution
  remove_column :users, :occupation
  remove_column :users, :year
  end
end
