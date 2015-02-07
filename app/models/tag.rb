class Tag < ActiveRecord::Base

	validates :name, presence: true, uniqueness: { scope: :project }

	belongs_to :user
	belongs_to :project

	def to_tag_array(tags)
		tags.squeeze(" ").strip.split(',')
	end
end
