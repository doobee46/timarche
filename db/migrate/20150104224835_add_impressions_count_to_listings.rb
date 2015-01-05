class AddImpressionsCountToListings < ActiveRecord::Migration
  def change
    add_column :listings, :impressions_count, :integer, default: 0
  end
end
