class Page < ActiveRecord::Base
  paginate_alphabetically :by => :name
  
  def alphabetical_group(letter = nil)
     letter ||= first_letter
     find(:all, :conditions => ["LOWER(#{@attribute.to_s}) LIKE ?", "#{letter.downcase}%"], :order => @attribute)
   end
   
end
