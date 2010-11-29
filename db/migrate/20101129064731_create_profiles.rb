class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.text :about
      t.string :institution
      t.string :occupation
      t.integer :year
      t.text :skills
      t.string :facebook
      t.string :twitter
      t.string :linked_in
      t.string :website
      t.string :other
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
