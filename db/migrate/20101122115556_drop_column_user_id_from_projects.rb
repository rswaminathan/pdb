class DropColumnUserIdFromProjects < ActiveRecord::Migration
  def self.up
	remove_column :projects, :user_id
  end

  def self.down
  end
end
