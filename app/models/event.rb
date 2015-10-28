class Event < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	has_and_belongs_to_many :authors
  has_and_belongs_to_many :users
	has_many :comments


	scope :sorted, lambda { order("events.name ASC")}
	scope :newest_first, lambda { order("events.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
