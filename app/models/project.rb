class Project < ApplicationRecord
	validates_presence_of :title, :description

	has_many :user_project, dependent: :delete_all
	has_many :users, through: :user_project
	has_many :bugs
end
