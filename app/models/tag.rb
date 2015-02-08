class Tag < ActiveRecord::Base
	
	validates :name, presence: true, uniqueness: { scope: :project }

	belongs_to :user
	belongs_to :project

end
