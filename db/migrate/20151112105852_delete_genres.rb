class DeleteGenres < ActiveRecord::Migration
  def self.up
    drop_table :genres
    drop_table :books_genres
  end

  def self.down
    create_table :books_genres, :id => false do |t|
      t.integer "book_id"
      t.integer "genre_id"
    end
    add_index :books_genres, ["book_id", "genre_id"]

    create_table :genres do |t|
      t.string "genre"
      t.references :book
      t.timestamps
    end
  end

end
