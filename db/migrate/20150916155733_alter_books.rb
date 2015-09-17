class AlterBooks < ActiveRecord::Migration
  def change
  	# add_column("books", "author_id", :integer)
  	add_column("books", "publisher", :string, :default => "")
  	add_column("books", "published_year", :date)
  	add_column("books", "word_count", :integer)
  	add_column("books", "page_count", :integer)
  	add_column("books", "isbn", :string, :default => "")
  	add_column("books", "permalink", :string)
  	add_index("books", "author_id")
  	add_index("books", "permalink")
   end
end
