class CreateAmenityProperties < ActiveRecord::Migration[7.2]
  def change
    create_table :property_amenities do |t|
      t.references :property, null: false, foreign_key: true
      t.references :amenity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
