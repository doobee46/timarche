class AddDisplayUsdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :display_usd, :boolean
  end
end
