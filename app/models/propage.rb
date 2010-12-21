class Propage < ActiveRecord::Base
  
    belongs_to :project

  end
  
# == Schema Information
#
# Table name: propages
#
#  id               :integer         not null, primary key
#  main_info        :text
#  progress         :text
#  press            :text
#  similar_projects :text
#  page_1_name      :string(255)
#  page_1_content   :text
#  page_2_name      :string(255)
#  page_2_content   :text
#  page_3_name      :string(255)
#  page_3_content   :text
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

