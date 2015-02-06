class Project < ActiveRecord::Base

	has_many :discussions, dependent: :destroy
	has_many :comments, through: :discussions

	has_many :tasks, dependent: :destroy

	has_many :contributions, dependent: :destroy
	has_many :contributing_users, through: :contributions, source: :user
	
	validates :title, presence: true, uniqueness: true
	
end
