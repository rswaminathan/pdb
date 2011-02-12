class Modifylike < ActiveRecord::Migration
  def self.up
    rename_column :likes, :like, :description
  end

  def self.down
    rename_column :likes, :description, :like
  end
end
