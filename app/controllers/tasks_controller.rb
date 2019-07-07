class TasksController < ApplicationController
 include SessionsHelper
 
 before_action :require_user_logged_in
 before_action :correct_user, only: [:show, :edit, :destroy, :update]
 

  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end


  def show
  end
  

  def new
    @task = Task.new(
     content: params[:content],
     user_id: @current_user.id
    )
  end
  

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end 
  

  def edit
  end
  

  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end


  def destroy
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
# ログイン中のユーザのtask一覧のidがparams[:id]と一致するものがあったら@taskに代入される。なければ@taskはnilになる。
# @taskに値が入っていなかったら（nilだったら）rootにリダイレクトする
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
     redirect_to '/'
    end
  end
  
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
    
end
