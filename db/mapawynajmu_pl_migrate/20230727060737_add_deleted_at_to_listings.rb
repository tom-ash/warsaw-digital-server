class AddDeletedAtToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :deleted_at, :datetime
  end
end
