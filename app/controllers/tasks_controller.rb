class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 10

  def index
    if logged_in?
      @tasks = Task.page(params[:page]).per(PER).where(user_id: current_user.id).desc_sort_create_at
    else
      redirect_to new_session_path
    end
  end

  def sort
    if logged_in?
      @tasks = Task.includes(:labels).references(:labels).page(params[:page]).per(PER).set_sort(params).where(user_id: current_user.id)
      render :index
    else
      redirect_to new_session_path
    end
  end

  def new
    if logged_in? && params[:back]
      @task = Task.new(task_params)
    elsif logged_in?
      @task = Task.new
    else
      redirect_to new_session_path
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @task.save
        flash[:success] = 'タスクを作成しました！'
        redirect_to task_path(@task.id)
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを編集しました！'
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました！'
    redirect_to tasks_url
  end

  private

  def set_task
    if logged_in?
      @task = Task.find(params[:id])
      @labels = Label.where("user_id is null or user_id = ?", current_user.id).order(created_at: "DESC")
    else
      redirect_to new_session_path
    end
  end

  def task_params
    params.require(:task).permit(:title, :details, :priority, :status, :limit, :user_id, label_ids: [] )
  end
end