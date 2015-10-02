class User < ActiveRecord::Base


has_secure_password

scope :sorted, lambda { order("users.last_name ASC, users.first_name ASC")}

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
 # 	validates_presence_of :first_name
 	# validates_length_of :first_name, :maximum => 25
 # 	validates_presence_of :last_name
 # 	validates_length_of :last_name, :maximum => 50
 # 	validates_presence_of :username
 # 	validates_length_of :username, :within => 8..25
 # 	validates_uniqueness_of :username
 # 	validates_presence_of :email
 # 	validates_length_of :email, :maximum => 100
 # 	validates_format_of :email, :with => EMAIL_REGEX
 # 	validates_confirmation_of :email
 # 	
 # 	validation shortcuts
 	validates :first_name, :presence => true,
 						   :length => { :maximum => 25}
 	validates :last_name, :presence => true,
 						  :length => { :maximum => 50}
 	validates :username, :length => { :within => 8..25},
 						 :uniqueness => true
 	validates :email, :presence => true,
 					  :length => { :maximum => 100},
 					  :format => EMAIL_REGEX,
 					  :confirmation => true


	has_many :reviews
	has_many :comments
	has_many :events
	has_many :book_exchanges
	has_many :books, :through => :book_exchanges

	scope :newest_first, lambda { order("users.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	def name
		first_name + " " + last_name
	end
end
