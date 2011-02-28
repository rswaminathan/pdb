class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :provider
      t.string :link
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
