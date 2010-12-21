class CreateProjectPages < ActiveRecord::Migration
  def self.up
    drop_table :project_pages
    end
  end

  def self.down
    drop_table :project_pages
  end
end
