class Tag < ActiveRecord::Base
		
	validates :name, presence: true, uniqueness: { scope: :project }

	belongs_to :user
	belongs_to :project

	has_many :taggings, dependent: :destroy
	has_many :tagged_projects, through: :taggings, source: :project
end
