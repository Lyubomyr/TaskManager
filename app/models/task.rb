# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ActiveRecord::Base
  has_many :sharings, :dependent => :destroy
  has_many :users, through: :sharings
  attr_accessible :content, :title
  attr_accessor :created_by

  after_find :find_owner

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :content, :presence => true, :length => { :maximum => 250 }

  default_scope :order => 'tasks.created_at DESC'

  def find_owner
  	share = Sharing.where("task_id=?", self.id).last
  	self.created_by = User.find_by_id(share.user_id).name if share
  end

end
