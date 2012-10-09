# == Schema Information
#
# Table name: sharings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sharing < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  attr_accessible :task_id, :user_id
end
