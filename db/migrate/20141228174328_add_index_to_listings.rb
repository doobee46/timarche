class AddIndexToListings < ActiveRecord::Migration
  def change
    add_index :listings, :listing_number
  end
end
