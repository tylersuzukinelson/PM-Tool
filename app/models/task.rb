class Task < ActiveRecord::Base

	belongs_to :project
	belongs_to :user

	validates :title, presence: true, uniqueness: { scope: :project_id,
    message: "Each task in project must be unique" }
    
end
