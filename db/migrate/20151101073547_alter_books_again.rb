class AlterBooksAgain < ActiveRecord::Migration
  def up
    rename_column("books", "permalink", "url")
  end

  def down
    rename_column("books", "url", "permalink")
  end
end
