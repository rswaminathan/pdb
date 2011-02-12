class AddAbstractToProject < ActiveRecord::Migration
  def self.up
        add_column :projects, :abstract, :string
  end

  def self.down
        remove_column :projects, :abstract
  end
end
