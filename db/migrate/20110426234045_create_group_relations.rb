class CreateGroupRelations < ActiveRecord::Migration
  def self.up
    create_table :group_relations do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :admin
      t.timestamps
    end
  end

  def self.down
    drop_table :group_relations
  end
end
