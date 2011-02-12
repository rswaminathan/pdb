class CreateProjectPages < ActiveRecord::Migration
  def self.up
    create_table :project_pages do |t|
      t.string :title
      t.text   :content
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_pages
  end
end
