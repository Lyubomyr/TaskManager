# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :title

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :content, :presence => true, :length => { :maximum => 250 }
  validates :user_id, :presence => true

  default_scope :order => 'tasks.created_at DESC'

end
