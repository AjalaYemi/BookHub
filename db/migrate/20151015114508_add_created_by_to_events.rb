class AddCreatedByToEvents < ActiveRecord::Migration
  def change
    add_column :events, :created_by, :integer, :default => 0
  end
end
