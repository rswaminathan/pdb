class AddFbUidToPreUser < ActiveRecord::Migration
  def self.up
    add_column :pre_users, :facebook_id, :string
  end

  def self.down
  end
end
