class Project < ActiveRecord::Base

	has_many :discussions, dependent: :destroy
	has_many :comments, through: :discussions
	
	validates :title, presence: true, uniqueness: true
	
end
