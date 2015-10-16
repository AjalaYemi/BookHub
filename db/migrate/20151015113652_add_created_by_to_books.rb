class AddCreatedByToBooks < ActiveRecord::Migration
  def change
    add_column :books, :created_by, :integer, :default => 0
  end
end
