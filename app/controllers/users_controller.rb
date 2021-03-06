 class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
        @title = "All users"
  	@users = User.paginate(:page => params[:page], :per_page => 20)
  end

  def new
	@title = "Sign up"
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
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

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    flash[:success] = "User '#{user.name}' destroyed."
    destroy_assoc_tasks(user)
    user.destroy
    redirect_to users_path
  end


  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end
  private

  def admin_user
      if current_user == nil
        redirect_to(signin_path)
      elsif current_user.admin? == false
        redirect_to(root_path)
      end
  end

  def destroy_assoc_tasks(user)
  	sharings = Sharing.where("user_id=?", user.id)
        sharings.each do |sharing|
	users_count = Sharing.where("task_id = ?", sharing.task_id).count
    	Task.find_by_id(sharing.task_id).destroy if users_count == 1
    end
  end
end
