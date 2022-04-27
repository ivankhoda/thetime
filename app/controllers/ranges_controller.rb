class RangesController < ApplicationController
  def new
    @task_range = TaskRange.new
  end

  def index
    @task = current_user.tasks.find_by(id: range_params[:task_id])
    range = @task.task_ranges
    render json: { range: }
  end

  def show
    @task = current_user.tasks.find_by(id: range_params[:task_id])
    range = @task.task_ranges.find_by(id: params[:id])
    render json: { range: }
  end

  def create
    @task_range = TaskRange.new(range_params)
    @task_range.task_id = current_user.tasks.find_by(id: range_params[:task_id]).id

    if @task_range.save
      render json: { range: @task_range }
    else
      render json: { message: @task_range.errors }
    end
  end

  def update
    @task = current_user.tasks.find_by(id: range_params[:task_id])
    range = @task.task_ranges.find_by(id: params[:id])
    if !range.nil?
      range.update(range_params)
      render json: { range: }
    else
      render json: { error: 'Range not found' }, status: 422
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: range_params[:task_id])
    range = @task.task_ranges.find_by(id: params[:id])
    if !range.nil?
      range.destroy
      render json: { message: 'Range deleted' }
    else
      render json: { error: 'Range not found' }, status: 422
    end
  end

  def range_params
    params.require(:range).permit(:from, :to, :task_id)
  end
end
