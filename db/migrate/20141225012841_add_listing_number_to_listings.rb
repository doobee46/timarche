class AddListingNumberToListings < ActiveRecord::Migration
  def change
    add_column :listings, :listing_number, :string
  end
end
