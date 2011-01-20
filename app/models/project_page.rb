class ProjectPage < ActiveRecord::Base
  belongs_to :project
  has_many :sections

end

# == Schema Information
#
# Table name: project_pages
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
#  created_at       :datetime
#  updated_at       :datetime
#  project_id       :integer
#

