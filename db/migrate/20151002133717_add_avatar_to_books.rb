class AddAvatarToBooks < ActiveRecord::Migration
  def change
    add_column :books, :front_avatar, :string
  end
end
