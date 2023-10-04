# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]
  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Updated task successfully'
    else
      render :edit
    end
  end

  def destroy
    @task&.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
