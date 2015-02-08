class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify

  has_many :contributions, dependent: :destroy
  has_many :contributed_projects, through: :contributions, source: :project

  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project

  has_many :tags, dependent: :destroy
  has_many :tagged_projects, through: :tags, source: :project

	def full_name
		if first_name || last_name
		  "#{first_name} #{last_name}".squeeze(" ").strip
		else
		  email
		end
	end

  def has_favorited?(project)
    favorite_projects.include?(project)
  end
end
