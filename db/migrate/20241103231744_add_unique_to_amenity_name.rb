class AddUniqueToAmenityName < ActiveRecord::Migration[7.2]
  def change
    add_index :amenities, :name, unique: true
  end
end
