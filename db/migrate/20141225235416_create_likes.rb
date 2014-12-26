class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :listing, index: true

      t.timestamps
    end
  end
end
