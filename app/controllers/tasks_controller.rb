class TasksController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
     @user = User.find(params[:user_id])
     #<!--タスクの値を取ってくる-->
     @task = @user.tasks.find_by(id: params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
    @task.update_attributes(task_params)
    redirect_to user_tasks_url(@user, @task)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
    @task.destroy
    redirect_to user_tasks_url @user
  end
  
  private

    def task_params
      params.require(:task).permit(:name, :description)
    end

end
