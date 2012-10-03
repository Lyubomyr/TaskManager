class Sharing < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  attr_accessible :task_id, :user_id
end
