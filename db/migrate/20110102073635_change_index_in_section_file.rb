class ChangeIndexInSectionFile < ActiveRecord::Migration
	def self.up
		remove_column	:sections,	:project_pages_id
		add_column		:sections,	:project_page_id,	:integer
		add_index		:sections,	:project_page_id
	end

	def self.down
		remove_index 	:sections,	:project_page_id
		remove_column	:sections,	:project_page_id
		add_column		:sections,	:project_pages_id,	:integer
	end
end
