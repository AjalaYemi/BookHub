class CreateBookExchanges < ActiveRecord::Migration
  def up
    create_table :book_exchanges do |t|
    	t.references :user
    	t.references :book
    	t.string "transaction_type"
    	t.datetime "initiated"
    	t.datetime "accepted"
    	t.datetime "completed"
      	t.timestamps
    end
    add_index :book_exchanges, ["user_id", "book_id"]
  end

  def down
  	drop_table :book_exchanges
  end
end
