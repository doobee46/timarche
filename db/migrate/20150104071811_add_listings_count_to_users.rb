class AddListingsCountToUsers < ActiveRecord::Migration
  def up
    add_column :users, :listings_count, :integer, default: 0, null: false

    User.find_each do |result|
      User.reset_counters(result.id, :listings)
    end
  end

  def down
    remove_column :users, :listings_count
  end
end
