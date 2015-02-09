class ProjectMailer < ApplicationMailer

  include Delayed::RecurringJob
  run_every 1.day
  run_at '11:00am'
  timezone 'US/Pacific'
  queue 'slow-jobs'

	def perform(project)
		@project = project
		@tasks = @project.tasks
		@discussions = @project.discussions

		@user = @project.user

		mail to: @user.email, subject: "Project Summary"
	end
	
end
