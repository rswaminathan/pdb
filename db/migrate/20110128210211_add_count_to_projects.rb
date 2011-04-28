class AddCountToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :count, :integer  
  end

  def self.down
    remove_column :projects, :count
  end
end
