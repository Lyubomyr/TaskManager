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

require 'spec_helper'

describe Task do

  before(:each) do
    @user = Factory(:user)
    @attr = {:title => "First task", :content => "value for content" }
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

  describe "validations" do

    it "should require a user id" do
      Task.new(@attr).should_not be_valid
    end

    it "should require nonblank title" do
      @user.tasks.build(:title => "  ").should_not be_valid
    end

    it "should reject long title" do
      @user.tasks.build(:title => "a" * 51).should_not be_valid
    end

    it "should require nonblank content" do
      @user.tasks.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.tasks.build(:content => "a" * 141).should_not be_valid
    end
  end


end
