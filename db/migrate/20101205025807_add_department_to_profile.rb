class AddDepartmentToProfile < ActiveRecord::Migration
  def self.up
        add_column :profiles, :department, :string
  end

  def self.down
        remove_column :profiles, :department, :string
  end
end
