class CommentsController < ApplicationController

	def create
		@discussion = Discussion.find params[:discussion_id]
		@comment = Comment.new comment_params

		@comment.discussion = @discussion

		#@comment.answer.user = current.user

		@comment.save

		redirect_to @discussion.project, notice: "New comment added"
	end

	def edit
		@discussion = Discussion.find params[:discussion_id]
		@comment = Comment.find params[:id]
	end

	def update
		@discussion = Discussion.find params[:discussion_id]
		@comment = Comment.find params[:id]

		if @comment.update comment_params
			redirect_to project_path(@discussion.project), notice: "Comment successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@comment = Comment.find params[:id]

		@comment.destroy
		redirect_to @comment.discussion.project, notice: "Comment deleted"
	end

private
	
	def comment_params
		params.require(:comment).permit(:body)
	end

end
