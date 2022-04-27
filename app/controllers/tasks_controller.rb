class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def index
    tasks = current_user.tasks
    render json: { tasks: }
  end

  def show
    task = current_user.tasks.find_by(id: params[:id])
    render json: { task: }
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

  def update
    task = current_user.tasks.find_by(id: params[:id])
    if !task.nil?
      task.update(task_params)
      render json: { task: }
    else
      render json: { error: 'Task not found' }, status: 422
    end
  end

  def destroy
    task = current_user.tasks.find_by(id: params[:id])
    if !task.nil?
      task.destroy
      render json: { message: 'Task was removed' }
    else
      render json: { error: 'Task not found' }, status: 422
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :task_category, :task_ranges, :task_status, :cost)
  end

  def find_user_task
    # TODO: make generic method
    task = current_user.tasks.find_by(id: params[:id])
    if !task.nil?
      task
    else
      "no task found for user #{current_user.uuid} with id #{params[:id]}"
    end
  end
end
