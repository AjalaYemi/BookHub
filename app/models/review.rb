class Review < ActiveRecord::Base
	belongs_to :book
	belongs_to :user
	has_many :comments

	scope :sorted, lambda { order("review ASC")}
	scope :newest_first, lambda { order("reviews.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
