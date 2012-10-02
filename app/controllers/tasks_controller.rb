class TasksController < ApplicationController
  before_filter :authenticate

  def index
    @tasks = current_user.tasks.paginate(:page => params[:page], :per_page => 5)
    @title = current_user.name
  end

  def show
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
      Mediator.create(user_id:current_user.id, task_id: @task.id)
      flash[:success] = "New task created!"
      redirect_to user_path(current_user)
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
end
