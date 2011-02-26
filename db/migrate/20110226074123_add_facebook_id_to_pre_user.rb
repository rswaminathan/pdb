class AddFacebookIdToPreUser < ActiveRecord::Migration
  def self.up
    add_column :pre_users, :facebook, :string
  end

  def self.down
    remove_column :pre_users, :facebook
  end
end
