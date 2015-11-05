class AddUrlToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :url, :string
  end
end
