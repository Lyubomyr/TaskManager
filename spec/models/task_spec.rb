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

require 'spec_helper'

describe Task do

  before(:each) do
    @user = Factory(:user)
    @attr = Factory.attributes_for(:task)
  end

  it "should create a new instance given valid attributes" do
    @user.tasks.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @task = @user.tasks.create(@attr)
    end

    it "should have a user attribute" do
      @task.should respond_to(:users)
    end

    it "should have the right associated user" do
      @user.tasks.first.should == @task
      @task.users.first.should == @user
    end
  end

  describe "validations" do

    it "should require nonblank title" do
      @user.tasks.build(:title => "  ").should_not be_valid
    end

    it "should reject long title" do
      @user.tasks.build(:title => "a" * 101).should_not be_valid
    end

    it "should require nonblank content" do
      @user.tasks.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.tasks.build(:content => "a" * 251).should_not be_valid
    end
  end


end
