class CreatePreUserProjectsJoinTable < ActiveRecord::Migration
  def self.up
      create_table :pre_users_projects, :id => false do |t|
      t.integer :project_id
      t.integer :pre_user_id
    end
  end

  def self.down
    drop_table :pre_users_projects
  end
end
