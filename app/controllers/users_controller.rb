class UsersController < ApplicationController
  
  def index
    @title = "Users List"
  	@users = User.all
  end

  def new
  	@title = "Sign up"
  	@user = User.new
  end

  def show
    @title = "User"
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "User successfuly created"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
