class Book < ActiveRecord::Base
	has_many :reviews
	has_many :comments
	has_many :book_exchanges
	has_many :users, :through => :book_exchanges
	has_and_belongs_to_many :authors
	has_and_belongs_to_many :genres

	before_validation :add_default_permalink
	# after_save :touch_author

	validates_presence_of :name
	validates_length_of :name, :maximum => 100
	validates_presence_of :publisher

	scope :sorted, lambda { order("books.name ASC")}
	scope :newest_first, lambda { order("books.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	private

	def add_default_permalink
		if permalink.blank?
			self.permalink = "#{id}-#{name.parameterize}"
		end		
	end

	# def touch_author
	# 	# touch is similar to:
	# 	# author.update_attribute(:update_at, Time.now)
	# 	author.touch
	# end
end
