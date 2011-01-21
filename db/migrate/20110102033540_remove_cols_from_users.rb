class RemoveColsFromUsers < ActiveRecord::Migration
	def self.up
		remove_column :users, :photo_file_name
		remove_column :users, :photo_file_size
		remove_column :users, :photo_content_type
		remove_column :users, :year
		remove_column :users, :occupation
		remove_column :users, :contact
		remove_column :users, :skills
		remove_column :users, :about
		remove_column :users, :institution
	end

	def self.down
		add_column :users, :institution, :string
		add_column :users, :about, :string
		add_column :users, :skills, :string
		add_column :users, :contact, :string
		add_column :users, :occupation, :string
		add_column :users, :year, :integer
		add_column :users, :photo_content_type, :string
		add_column :users, :photo_file_size, :integer
		add_column :users, :photo_file_name, :string
	end
end
