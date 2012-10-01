class TasksController < ApplicationController
  before_filter :authenticate

  def create
    @task  = current_user.tasks.build(params[:task])
    if @task.save
      flash[:success] = "New task created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
end
