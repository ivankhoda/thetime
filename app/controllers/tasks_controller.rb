class TasksController < ApplicationController
  # protect_from_forgery with: :null_session
  def new
    @task = Task.new
  end

  def index
    puts task_params
    tasks = Task.all
    render json: { tasks: }
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      render json: { task: @task }
    else
      render json: { message: @task.errors }
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :user_id)
  end
end
