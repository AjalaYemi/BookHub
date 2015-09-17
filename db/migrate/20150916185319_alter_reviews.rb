class AlterReviews < ActiveRecord::Migration
  def change
  	add_index("reviews", "user_id")
  	add_index("reviews", "book_id")
  end
end
