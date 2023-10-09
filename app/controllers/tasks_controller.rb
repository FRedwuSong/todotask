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

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: I18n.t('controllers.tasks.create.notice') }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: I18n.t('controllers.tasks.update.notice') }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task&.destroy
    redirect_to tasks_path, notice: I18n.t('controllers.tasks.destroy.notice')
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
