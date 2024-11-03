class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :checkin_date, presence: true
  validates :checkout_date, presence: true

  # Truy vấn tất cả các đặt phòng sắp tới (tương lai) và sắp xếp theo ngày nhận phòng.
  scope :upcoming_reservations, -> { where("checkin_date > ?", Date.today).order(:checkin_date) }
  scope :current_reservations, -> { where("checkout_date > ?", Date.today).where("checkin_date < ?", Date.today).order(:checkin_date) }
end