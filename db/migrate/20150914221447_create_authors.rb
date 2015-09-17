class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
    	t.string "first_name", :limit => 25, :null => false
    	t.string "last_name", :limit => 25, :default => ""
    	t.text "bio"
      t.timestamps
    end
  end
end
