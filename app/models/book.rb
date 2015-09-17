class Book < ActiveRecord::Base

	has_many :reviews
	has_many :comments
	has_many :book_exchanges
	has_many :users, :through => :book_exchanges
	has_and_belongs_to_many :authors
	has_and_belongs_to_many :genres

	scope :sorted, lambda { order("books.name ASC")}
	scope :newest_first, lambda { order("books.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
