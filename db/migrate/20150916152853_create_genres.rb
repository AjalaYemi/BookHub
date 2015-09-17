class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
    	t.string "genre"
    	t.references :book
      t.timestamps
    end
  end
end
