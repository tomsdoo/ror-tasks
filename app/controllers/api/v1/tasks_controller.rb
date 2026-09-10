# app/controllers/api/v1/tasks_controller.rb
class Api::V1::TasksController < ActionController::API
  before_action :set_task, only: [:update, :destroy]

  # GET /api/v1/tasks
  def index
    tasks = Task.order(created_at: :desc)
    render json: tasks, status: :ok
  end

  # POST /api/v1/tasks
  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/:id
  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/:id
  def destroy
    @task.destroy
    head :no_content # レスポンスボディなし (HTTP 204 No Content)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Task not found" }, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
