class Author < ActiveRecord::Base

	has_and_belongs_to_many :books
	has_and_belongs_to_many :events

	scope :sorted, lambda { order("authors.last_name ASC, authors.first_name ASC")}
	# scope :first_author, lambda { limit(1)}
	scope :newest_first, lambda { order("authors.created_at DESC")}
	scope :search, lambda {|query|
		where(["first_name LIKE ?", "%#{query}%"])
	}

	
	def name
		first_name + " " + last_name
	end
end
