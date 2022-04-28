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
    @task_range = task_range_params.to_h.to_h

    # # Присваиваю задаче юзер ид
    @task.user_id = current_user.id
    range = TaskRange.new(@task_range)
    # # Пытаюсь если задача сохраняется, то я создаю для нее временной промежуток
    if @task.save
      puts @task, 'task in save'

      range.update(task_id: @task.id)
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

  def start
    @task = current_user.tasks.find_by(id: params[:task][:task_id])
    task_range = TaskRange.new(from: DateTime.current)
    @task.task_ranges.push(task_range)

    if !@task.nil?
      @task.update(task_params)
      render json: { task: @task }
    else
      render json: { error: 'Task not found' }, status: 422
    end
  end

  def stop
    task = current_user.tasks.find_by(id: params[:task][:task_id])
    task_range = task.task_ranges.find { |range| range.to.blank? }
    puts task_range
    if task_range.update(to: DateTime.current)

      render json: { message: task_range }
    else
      render json: { message: 'Cannot stop task' }
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :task_category, :task_status, :cost)
  end

  def task_range_params
    params.require(:task).permit(task_ranges: %i[from to])
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
