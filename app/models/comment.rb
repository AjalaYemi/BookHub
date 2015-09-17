class Comment < ActiveRecord::Base

	belongs_to :book
	belongs_to :user
	belongs_to :review
	belongs_to :event
end
