class AddTopTagsToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :top_tags, :string
    
  end

  def self.down
    remove_column :profiles, :department
    
  end
end
