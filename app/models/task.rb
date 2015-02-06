class Task < ActiveRecord::Base

	belongs_to :project

	validates :title, presence: true, uniqueness: { scope: :project_id,
    message: "Each task in project must be unique" }

    # def is_complete?
    # 	self.completed_status
    # end
 

end
