class FavoritesController < ApplicationController

	def create
		@project = Project.find params[:project_id]
		@favorite = @project.favorites.new
		@favorite.user = current_user

		if @favorite.save
			redirect_to @project
		else
			redirect_to @project
		end
	end

	def destroy
		@project = Project.find params[:project_id]
		@favorite = @project.favorites.find params[:id]

		if @favorite.destroy
			redirect_to @project
		else
			redirect_to @project
		end
	end

end
