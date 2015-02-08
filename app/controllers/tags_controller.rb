class TagsController < ApplicationController
	
	def create
		@project = Project.find params[:project_id]
		@tag = @project.tags.new tag_params

		if @tag.save
			redirect_to @project, notice: "Tags added!"
		else
			redirect_to @project, notice: "Tags not added."
		end
	end

private

	def tag_params
		tag_params = params.require(:tag).permit(:name)
	end
end
