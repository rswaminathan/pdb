class CreatePropages < ActiveRecord::Migration
    def self.up
      create_table :project_pages do |t|
        t.text :main_info
        t.text :progress
        t.text :press
        t.text :similar_projects
        t.string :page_1_name
        t.text :page_1_content
        t.string :page_2_name
        t.text :page_2_content
        t.string :page_3_name
        t.text :page_3_content
      end
    end

    def self.down
      drop_table :project_pages
    end
  end
