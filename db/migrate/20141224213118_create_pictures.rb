class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :description
      t.references :listing, index: true

      t.timestamps
    end
  end
end
