class CommentsController < ApplicationController

	def create
		@discussion = Discussion.find params[:discussion_id]
		@comment = Comment.new comment_params

		@comment.discussion = @discussion

		respond_to do |format|
			if @comment.save
				if current_user != @comment.discussion.user
					DiscussionMailer.delay.notify_discussion_owner(@comment)
				end
				format.html {redirect_to @discussion.project, notice: "New comment added"}
				format.js {render}
			else
				format.html {redirect_to @discussion.project, notice: "Comment not added"}
				format.js {render}
			end
		end
		
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
		
		respond_to do |format|
			format.html {redirect_to @comment.discussion.project, notice: "Comment deleted"}
			format.js {render}
		end
	end

private
	
	def comment_params
		params.require(:comment).permit(:body)
	end

end
