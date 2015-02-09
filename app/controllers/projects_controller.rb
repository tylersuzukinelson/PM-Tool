class ProjectsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
		@project.due_date = Date.today
	end

	def create
		@project = Project.new project_params
		@project.user = current_user


		if @project.save
			ProjectMailer.schedule!
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

		@task = Task.new
		@task.project = @project

		@tag = Tag.new
		@all_tags = to_tag_array(@project.tags)

		@contributors = @project.contributing_users
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
		ProjectMailer.unschedule


		@project.destroy
		redirect_to projects_path, notice: "Project successfully deleted!"
	end

private
	
	def find_project
		@project = Project.find params[:id]
	end

	def project_params
		project_params = params.require(:project).permit(:title, :description, :due_date, :tag_list, {contributing_user_ids: []})
	end

	def to_tag_array(tags)
		temp_tag_array = []
		tag_array = []

		if !tags.nil?
			tags.each do |tag|
				temp_tag_array << tag.name.split(',')

				temp_tag_array.each do |item|
					unless tag_array.include? item
						tag_array << item
					end
				end
			end
		end

		return tag_array
	end

end
