class TasksController < ApplicationController
  before_filter :authenticate

  def index
    @tasks = current_user.tasks.paginate(:page => params[:page], :per_page => 5)
    @title = current_user.name
  end

  def show
	gon.users_names = User.all.map do |user|
				user.email
			  end
  	@task = current_user.tasks.find(params[:id])
    	@title = current_user.name
  end

  def new
	@title = "Sign up"
	@task = current_user.tasks.build
  end

  def create
    @task  = current_user.tasks.build(params[:task])
    if @task.save
      Sharing.create(user_id:current_user.id, task_id: @task.id)
      flash[:success] = "New task created!"
      redirect_to user_tasks_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @title = "Edit task"
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = "Task updated."
      redirect_to ([current_user, @task])
    else
      @title = "Edit task"
      render 'edit'
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    flash[:success] = "Task '#{task.title}' destroyed."
    task.destroy
    redirect_to user_tasks_url(current_user)
  end


  def share
    task_id = params[:id]
    @task = Task.find(task_id)

    user_id = sharing_user_id(params[:sharing_user_email])
    if user_id
	    unless already_shared?(user_id, task_id)
		    Sharing.create(user_id: user_id, task_id: task_id)
		    @user_path = user_path(User.find(user_id))
		    @message = "Task #{@task.title} shared to #{User.find(user_id).name}"
	    else
	    	    @message = "Task already shared to this user"
    	    end
    else
	    @message = "There is no user with such email"
    end
    	    respond_to do |format|
    		format.js
    	    end
  end

  private
  def sharing_user_id(sharing_user_email)
	user = User.where("email=?", sharing_user_email)
	!user.empty? ? user.first.id : false
  end

  def already_shared?(user_id, task_id)
  	shared_tasks = Sharing.where("task_id=?", task_id )

	shared_tasks.each do |shared_task|
		(shared_task.user_id == user_id) ? (return true) : false
	end
	false
  end

end
