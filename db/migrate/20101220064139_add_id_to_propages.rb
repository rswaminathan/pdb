class AddIdToPropages < ActiveRecord::Migration
  def self.up
    add_column :project_pages, :project_id, :integer
    
  end

  def self.down
    remove_column :project_pages
    
  end
end
