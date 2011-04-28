class AddMainfileToProject < ActiveRecord::Migration
    def self.up
      add_column :projects, :mainfile_file_name, :string
      add_column :projects, :mainfile_content_type, :string
      add_column :projects, :mainfile_file_size, :integer
    end

    def self.down
      remove_column :projects, :mainfile_file_size
      remove_column :projects, :mainfile_content_type
      remove_column :projects, :mainfile_file_name
    end
  end