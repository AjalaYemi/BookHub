class Event < ActiveRecord::Base

	has_and_belongs_to_many :authors
	has_many :comments

	scope :sorted, lambda { order("books.name ASC")}
	scope :newest_first, lambda { order("books.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
