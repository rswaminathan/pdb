class AddPictureandBannertoGroups < ActiveRecord::Migration
  def self.up
 
    add_column :groups, :photo_file_name, :string
    add_column :groups, :photo_content_type, :string
    add_column :groups, :photo_file_size, :integer  
    add_column :groups, :banner_link, :string
    add_column :groups, :banner_file_name, :string
    add_column :groups, :banner_content_type, :string
    add_column :groups, :banner_file_size, :integer
  end

  def self.down
    remove_column :groups, :photo_file_name
    remove_column :groups, :photo_content_type
    remove_column :groups, :photo_file_size    
    remove_column :groups, :banner_link
    remove_column :groups, :banner_file_name
    remove_column :groups, :banner_content_type
    remove_column :groups, :banner_file_size
  end
end
