class CreateWishlists < ActiveRecord::Migration[7.2]
  def change
    create_table :wishlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
    # đảm bảo mỗi người dùng chỉ có thể tạo một wishlist duy nhất cho một property.
    add_index :wishlists, [ :user_id, :property_id ], unique: true
  end
end
