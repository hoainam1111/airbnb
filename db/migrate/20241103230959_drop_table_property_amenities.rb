class DropTablePropertyAmenities < ActiveRecord::Migration[7.2]
  def up
    drop_table :property_amenities
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
