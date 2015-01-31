class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
		@project.due_date = Date.today
	end

	def create
		@project = Project.new project_params

		if @project.save
			redirect_to projects_path, notice: "Project successfully created!"
		else
			render :new
		end
	end

	def edit
		@project = Project.find params[:id]
	end

	def show
		@project = Project.find params[:id]
		@discussion = Discussion.new
		@discussions = @project.discussions
	end

	def update
		@project = Project.find params[:id]

		if @project.update project_params
			redirect_to @project, notice: "Project successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@project = Project.find params[:id]

		@project.destroy
		redirect_to projects_path, notice: "Project successfully deleted!"
	end

private
	
	def find_project
		@project = Project.find params[:id]
	end

	def project_params
		project_params = params.require(:project).permit(:title, :description, :due_date)
	end

end
