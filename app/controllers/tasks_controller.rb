class TasksController < ApplicationController
	before_action :find_task, only: [:show, :edit, :update, :destroy, :mark_complete, :mark_incomplete]

	def index
		@tasks = Task.all
	end

	def new
		@project = Project.find params[:project_id]
		@task = Task.new
		@task.due_date = Date.today
	end

	def create
		@project = Project.find params[:project_id]
		@task = Task.new task_params

		@task.user = current_user


		@task.project = @project

		if @task.save
			redirect_to @project, notice: "Task successfully created!"
		else
			render :new
		end
	end

	def edit
		@project = Project.find params[:project_id]
	end

	def show
		@project = Project.find params[:project_id]
	end

	def update
		@project = Project.find params[:project_id]
		if @task.update task_params
			redirect_to project_task_path(@project, @task), notice: "Task successfully updated!"
		else
			render :edit
		end
	end

	def mark_complete
		@project = Project.find params[:project_id]
		@task.update(completed_status: true)

		if current_user != @task.user
			#TaskMailer.notify_task_owner(@task).deliver_later
			TaskMailer.delay.notify_task_owner(@task)
		end

		redirect_to project_task_path(@project, @task), notice: "Task successfully updated!"
	end

	def mark_incomplete
		@project = Project.find params[:project_id]		
		@task.update(completed_status: false)
		redirect_to project_task_path(@project, @task), notice: "Task successfully updated!"
	end

	def destroy
		@project = Project.find params[:project_id]
		@task.destroy
		redirect_to project_path(@project), notice: "Task successfully deleted!"
	end

private
	def find_task
		@task = Task.find params[:id]
	end

	def task_params
		task_params = params.require(:task).permit(:title, :due_date, :body, :completed_status)
	end
end
