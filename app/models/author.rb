class Author < ActiveRecord::Base

	has_and_belongs_to_many :books
	has_and_belongs_to_many :events

	scope :sorted, lambda { order("authors.name ASC")}
	scope :newest_first, lambda { order("authors.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
