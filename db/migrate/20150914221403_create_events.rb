class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string "name"
    	t.string "venue"
    	t.string "city"
    	t.integer "no_of_available_seats"
    	t.references :user
    	

      t.timestamps
    end
  end
end
