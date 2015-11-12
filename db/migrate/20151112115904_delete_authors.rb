class DeleteAuthors < ActiveRecord::Migration
  def self.up
    remove_column :authors, :avatar, :string
    drop_table :authors_events
    drop_table :authors_books
    drop_table :authors
  end

  def self.down
    create_table :authors do |t|
      t.string "first_name", :limit => 25, :null => false
      t.string "last_name", :limit => 25, :default => ""
      t.text "bio"
      t.timestamps
    end
    create_table :authors_books, :id => false do |t|
      t.integer "author_id"
      t.integer "book_id"
    end
    add_index :authors_books, ["author_id", "book_id"]
    create_table :authors_events, :id => false do |t|
      t.integer "author_id"
      t.integer "event_id"
    end
    add_index :authors_events, ["author_id", "event_id"]
    add_column :authors, :avatar, :string
  end
end
