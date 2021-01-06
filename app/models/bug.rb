class Bug < ApplicationRecord
  validates_presence_of :title, :bugtype, :status
  validates_uniqueness_of :title
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :developer, class_name: 'User'
  belongs_to :project

  enum bugtype: { bug: 0, feature: 1 }

  mount_uploader :screenshot, ImageUploader

end
