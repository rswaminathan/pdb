class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.integer :project_id
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
