class CreatePreUsers < ActiveRecord::Migration
  def self.up
    create_table :pre_users do |t|
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :pre_users
  end
end
