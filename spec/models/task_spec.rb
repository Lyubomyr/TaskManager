# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Task do

  before(:each) do
    @user = Factory(:user)
    @attr = {:name => "First task", :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.tasks.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @tasks = @user.tasks.create(@attr)
    end

    it "should have a user attribute" do
      @tasks.should respond_to(:user)
    end

    it "should have the right associated user" do
      @tasks.user_id.should == @user.id
      @tasks.user.should == @user
    end
  end


end
