class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.date :checkin_date
      t.date :checkout_date

      t.timestamps
    end
    # đảm bảo mỗi người dùng chỉ có thể tạo một resevation duy nhất cho một property.
  end
end
