class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :project_id
      t.integer :user_id
      t.string  :like
      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
