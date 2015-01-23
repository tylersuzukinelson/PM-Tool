class Task < ActiveRecord::Base

	validates :title, presence: true, uniqueness: { scope: :project_id,
    message: "Each task in project must be unique" }
 

end
