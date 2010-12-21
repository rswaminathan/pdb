class DropProjectPages < ActiveRecord::Migration
  def self.up
    drop_table :project_pages
  end

  def self.down
    drop_table :project_pages
  end
end
