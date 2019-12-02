class ProjectsController < ApplicationController
  def index
    begin 
      user = User.find(params.require(:user_id))
      render json: user.active_projects
    rescue ActiveRecord::RecordNotFound => e
      render json:{message: 'User not found'}
    end
  end

  def create 
    project = Project.create(project_params.merge(user_id: params.require(:user_id)))
    if project.valid? 
      render json: project
    else 
      render(json: {error: 'Project not created'}, status: 500)
    end
  end 

  def show
    project = Project.find(params.permit(:id))
    render json: project
  end

  def update 
    # add validation
    project = Project.find(params.permit(:id))
    project.update(project_params)
    render json: project
  end

  def destroy 
    # add validation
    project = Project.find(params.permit(:id))
    project.update(is_deleted: true)
    render json: project
  end

  private 
  def project_params
    params.require(:project).permit(:name, :description, :deadline, :is_completed, :priority, :is_deleted)
  end
end
