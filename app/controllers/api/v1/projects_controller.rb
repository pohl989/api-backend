class Api::V1::ProjectsController < ApplicationController
  before_action :set_up_project, only: [:show, :update, :destroy]
  
  def index
    @projects = Project.all
    
    render json: @projects
  end

  def show
    render json: @project
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private

  def set_up_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :id, :description)
    end
end
