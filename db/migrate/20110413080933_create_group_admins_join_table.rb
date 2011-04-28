class CreateGroupAdminsJoinTable < ActiveRecord::Migration
  def self.up
      create_table :groups_admins, :id => false do |t|
      t.integer :group_id
      t.integer :admin_id
    end
  end

  def self.down
      drop_table :groups_admins
  end
end
