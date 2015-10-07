class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable


	has_many :reviews
	has_many :comments
	has_many :events
	has_many :book_exchanges
	has_many :books, :through => :book_exchanges

	scope :sorted, lambda { order("users.last_name ASC, users.first_name ASC")}
	scope :newest_first, lambda { order("users.created_at DESC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	# For delayed email sending by Devise using the Delayed Job gem
	# def send_devise_notification(notification, *args)
 #  		devise_mailer.send(notification, self, *args).deliver_later
	# end

	def name
		first_name + " " + last_name
	end
end
