class CreateAuthorsEventsJoin < ActiveRecord::Migration
  def up
    create_table :authors_events, :id => false do |t|
    	t.integer "author_id"
    	t.integer "event_id"
    end
    add_index :authors_events, ["author_id", "event_id"]
  end

  def down
  	drop_table :authors_events
  end
end
