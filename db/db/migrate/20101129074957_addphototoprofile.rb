class Addphototoprofile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :photo_file_name, :string
    add_column :profiles, :photo_content_type, :string
    add_column :profiles, :photo_file_size, :integer
  end

  def self.down
    remove_column :profiles, :photo_file_size
    remove_column :profiles, :photo_content_type
    remove_column :profiles, :photo_file_name
  end
end
