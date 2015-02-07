class Project < ActiveRecord::Base

	belongs_to :user

	has_many :discussions, dependent: :destroy
	has_many :comments, through: :discussions

	has_many :tasks, dependent: :destroy

	has_many :contributions, dependent: :destroy
	has_many :contributing_users, through: :contributions, source: :user

	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user

	has_many :tags, dependent: :destroy
	has_many :tagged_users, through: :tags, source: :user
	
	validates :title, presence: true, uniqueness: true
	
end
