class AddColumnToAmenities < ActiveRecord::Migration[7.2]
  def change
    add_column :amenities, :icon, :string
  end
end
