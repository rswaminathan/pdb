class AddQuotetoUsers < ActiveRecord::Migration
  def self.up
    add_column :profiles, :quote, :text
    
  end

  def self.down
    remove_column :profiles, :quote
    
  end
  
end
