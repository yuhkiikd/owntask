class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_sort, only: [:sort]

  def index
    @tasks = Task.all.order(created_at: "DESC")
  end

  def sort
    render :index
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :details, :priority, :status, :limit)
  end

  def set_sort
    if params[:sort_limit_desc]
      @tasks = Task.all.order(limit: "DESC")
    elsif params[:sort_priority_asc]
      @tasks = Task.all.order(priority: "ASC")
    else
      if params[:title] != "" && params[:status] == ""
      @tasks = Task.where("title LIKE ?", "%#{ params[:title] }%")
      elsif params[:title] == "" && params[:status] != ""
        @tasks = Task.where("status LIKE ?", "%#{ params[:status] }%")
      elsif params[:title] != "" && params[:status] != ""
        @tasks = Task.where("status LIKE ?", "%#{ params[:status] }%")
                    .where("title LIKE ?", "%#{ params[:title] }%")
      end
    end
  end
end