class CreateSections < ActiveRecord::Migration
	def self.up
		create_table :sections do |t|
			t.string :title
			t.text :content
			t.string :photo_file_name
			t.string :photo_content_type
			t.integer :photo_file_size
			t.integer :project_pages_id

			t.timestamps
		end
		add_index :sections, :project_pages_id
	end

	def self.down
		drop_table :sections
	end
end
