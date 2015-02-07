class DiscussionsController < ApplicationController
	
	before_action :find_project
	#before_action :authenticate_user!

	def create
		@discussion = Discussion.new discussion_params
		@discussion.project = @project

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
		#@discussion = current_user.answers.find params[:id]
		
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


