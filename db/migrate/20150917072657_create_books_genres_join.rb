class CreateBooksGenresJoin < ActiveRecord::Migration
  def up
    create_table :books_genres, :id => false do |t|
    	t.integer "book_id"
    	t.integer "genre_id"
    end
    add_index :books_genres, ["book_id", "genre_id"]
  end

  def down
  	drop_table :books_genres
  end

end
