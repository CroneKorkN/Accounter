class TasksController < ApplicationController
  before_action :redirect_to_current_task,
                only: [:show]
  before_action :set_task,
                only: [:show, :edit, :update, :destroy]
  before_action :authorize,
                only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    Observer.find_or_create_by(session_id: session[:session_id])
            .update(task_id: @task.id, updated_at: DateTime.now)
    @my_tasks = current_user.tasks.where.not(id: current_user.current_task.id)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    task = current_user.tasks.create(name: "Neue Aufgabe")
    render text: task.name
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :no_content }
    end
  end

  private
    
  def redirect_to_current_task
    redirect_to current_user.current_task if not params[:id]
  end

  def set_task
    @task = Task.find_by(id: params[:id])
    current_user.update current_task: @task
  end

  def authorize
    flash[:notice] = "Access prohibited"
    redirect_to current_user.tasks.last if not @task.accessible_by? current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:name)
  end
end
