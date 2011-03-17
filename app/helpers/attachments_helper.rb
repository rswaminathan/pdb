module AttachmentsHelper

  def icon_finder(filename)
    if filename[-4,1] == "."
      type = filename[-3,3]
    elsif filename [-5,1] == "."
      type = filename [-4,4]
    else 
      type = "None"
    end
  end

end

