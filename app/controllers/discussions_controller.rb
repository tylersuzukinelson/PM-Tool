class DiscussionsController < ApplicationController
	
	before_action :find_project

	def create
		@discussion = Discussion.new discussion_params
		@discussion.project = @project
		@discussion.user = current_user

		if @discussion.save
			redirect_to @project, notice: "Discussion susccessfully created!"
		else
			redirect_to @project, alert: "Discussion not created"
		end
	end

	def edit
		@discussion = Discussion.find params[:id]
	end

	def update

		@discussion = Discussion.find params[:id]

		if @discussion.update discussion_params
			redirect_to @project, notice: "Discussion successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@discussion = Discussion.find params[:id]

		@discussion.destroy
		redirect_to project_path(@project), notice: "Discussion deleted"
	end

private
	def find_project
		@project = Project.find params[:project_id]
	end

	def discussion_params
		discussion_params = params.require(:discussion).permit(:title, :description)
	end
end


