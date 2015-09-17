class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
     # t.integer :user_id
      t.string :name
      t.date :birthday
     # add_index("profiles", "user_id")

      t.timestamps
    end
  end
end
