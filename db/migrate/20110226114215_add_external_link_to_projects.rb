class AddExternalLinkToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :external_link, :string
  end

  def self.down
  end
end
