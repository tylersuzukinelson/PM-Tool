class Project < ActiveRecord::Base

	belongs_to :user

	has_many :discussions, dependent: :destroy
	has_many :comments, through: :discussions

	has_many :tasks, dependent: :destroy

	has_many :contributions, dependent: :destroy
	has_many :contributing_users, through: :contributions, source: :user

	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	
	validates :title, presence: true, uniqueness: true

	def self.tagged_with(name)
		Tag.find_by_name(name).projects
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").
		joins(:taggins).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:name).join(", ")
	end

	def tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip).first_or_create!
		end
	end


	# def send_update_email
	# 	ProjectMailer.delay.update_project_owner(self)
	# end
	
end
