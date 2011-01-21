class CreateRelationshipProjects < ActiveRecord::Migration
	def self.up
		create_table :relationship_projects do |t|
			t.integer :follower_id
			t.integer :followed_id

			t.timestamps
		end
		add_index :relationship_projects, :follower_id
		add_index :relationship_projects, :followed_id
		add_index :relationship_projects, [:follower_id, :followed_id], :unique => true
	end

	def self.down
		drop_table :relationship_projects
	end
end
