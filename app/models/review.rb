class Review < ActiveRecord::Base

  acts_as_url :title, blacklist: %w{new search contact_us}

  acts_as_commentable

	belongs_to :book
	belongs_to :user
	has_many :comments

	scope :sorted, lambda { order("review ASC")}
	scope :newest_first, lambda { order("reviews.created_at DESC")}
	# scope :search, lambda {|query|
	# 	where(["name LIKE ?", "%#{query}%"])
	# }


  def to_param
    url # or whatever you set :url_attribute to
  end
end
