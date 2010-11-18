require 'test_helper'

class ProjectsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  kind        :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

