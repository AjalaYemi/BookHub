class RemoveUserIdAndAddDescriptionToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :user_id, :integer
    add_column :events, :description, :text
  end
end
