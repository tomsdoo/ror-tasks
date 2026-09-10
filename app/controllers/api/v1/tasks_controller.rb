class Api::V1::TasksController < ActionController::API
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

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
