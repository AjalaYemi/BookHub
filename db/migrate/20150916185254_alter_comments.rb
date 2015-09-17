class AlterComments < ActiveRecord::Migration
  def change
  	add_index("comments", "user_id")
  	add_index("comments", "book_id")
  	add_index("comments", "review_id")
  	add_index("comments", "event_id")
  end
end
