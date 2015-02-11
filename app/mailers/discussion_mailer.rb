class DiscussionMailer < ApplicationMailer
	def notify_discussion_owner(comment)
		@comment = comment
		@discussion = @comment.discussion
		@user = @discussion.user

		mail to: @user.email, subject: "Someone has commented on your discussion!"
	end
end
