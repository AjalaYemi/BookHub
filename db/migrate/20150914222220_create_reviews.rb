class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.text "review"
    	t.references :user
    	t.references :book

      t.timestamps
    end
  end
end
