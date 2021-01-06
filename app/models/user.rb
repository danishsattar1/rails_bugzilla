class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

     validates_presence_of :name, :usertype

     has_many :user_project, dependent: :delete_all
     has_many :projects, through: :user_project
     has_many :bugs

     def self.notManager
     	where.not(usertype: 'Manager')
     end  
     def self.developers
      where(usertype: 'Developer')
     end 

     def name_with_role
        "#{name} - #{usertype}"
      end

end
