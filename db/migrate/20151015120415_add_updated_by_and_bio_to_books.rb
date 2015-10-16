class AddUpdatedByAndBioToBooks < ActiveRecord::Migration
  def change
    add_column :books, :updated_by, :integer, :default => 0
    add_column :books, :bio, :text
  end
end
