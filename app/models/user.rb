class User < ActiveRecord::Base

	has_many :reviews
	has_many :comments
	has_many :book_exchanges
	has_many :books, :through => :book_exchanges

	scope :newest_first, lambda { order("users.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}
end
