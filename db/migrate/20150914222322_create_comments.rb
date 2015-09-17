class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text "comment", :limit => 250
    	t.references :user
    	t.references :book
    	t.references :review
      t.references :event    	
      t.timestamps
    end
  end
end
