class AddSkillsAndContact < ActiveRecord::Migration
  def self.up
  add_column :users, :skills, :text
  add_column :users, :contact, :text
  end

  def self.down
  remove_column :users, :skills
  remove_column :users, :contact
  end
end
