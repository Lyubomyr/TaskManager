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

require 'spec_helper'

describe Sharing do

  before(:each) do
    @user = Factory(:user)
    @task = Factory(:task)
  end

  it "make connection between User and Task" do
    Sharing.create!(user_id: @user.id, task_id: @task.id)
    @user.tasks.first.should == @task
    @task.users.first.should == @user
  end
end
