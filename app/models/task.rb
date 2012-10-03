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
  has_many :sharings
  has_many :users, through: :sharings
  attr_accessible :content, :title
  attr_accessor :created_by

  after_find :find_owner

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :content, :presence => true, :length => { :maximum => 250 }

  default_scope :order => 'tasks.created_at DESC'

  def find_owner
  	user_id = Sharing.where(task_id: self.id).first.user_id
  	self.created_by = User.find(user_id).name
  end

end
