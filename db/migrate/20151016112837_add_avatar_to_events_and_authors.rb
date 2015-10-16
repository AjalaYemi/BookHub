class AddAvatarToEventsAndAuthors < ActiveRecord::Migration
  def change
    add_column :events, :avatar, :string
    add_column :authors, :avatar, :string
  end
end
