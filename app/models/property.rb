class Property < ApplicationRecord
  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true


  monetize :price_cents, allow_nil: true
  has_many_attached :images
  has_many :reviews, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  # hiết lập mối quan hệ thông qua bảng trung gian wishlists, với source là user, để lấy ra tất cả người dùng đã wishlist một property.
  has_many :wishlisted_users, through: :wishlists, source: :user, dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy

  has_many :property_amenities, dependent: :destroy
  has_many :amenities, through: :property_amenities, source: :amenity, dependent: :destroy
  # rubocop:disable Layout/TrailingWhitespace
  has_rich_text :description

  has_many :payments, through: :reservations, dependent: :destroy

  def update_average_rating
    # this will get called whenever a new review is added or updated.
    average_rating = reviews.average(:final_rating)
    update_column(:average_final_rating, average_rating)
  end
  def average_cleanliness_rating
    reviews.average(:cleanliness_rating).to_f.round(1)
  end
  def average_accuracy_rating
    reviews.average(:accuracy_rating).to_f.round(1)
  end
  def average_checkin_rating
    reviews.average(:checkin_rating).to_f.round(1)
  end
  def average_communication_rating
    reviews.average(:communication_rating).to_f.round(1)
  end
  def average_location_rating
    reviews.average(:location_rating).to_f.round(1)
  end
  def average_value_rating
    reviews.average(:value_rating).to_f.round(1)
  end
  def wishlisted_by?(user = nil)
    # Nếu user là nil,
    # phương thức sẽ trả về false ngay lập tức.
    # Điều này giúp đảm bảo rằng nếu không có người dùng nào được cung cấp, phương thức sẽ không thực hiện kiểm tra
    # và trả về false thay vì nil.
    return if user.nil?
    # Sử dụng phương thức include? để kiểm tra xem user có nằm trong danh sách wishlisted_users hay không.
    wishlisted_users.include?(user)
  end


  # Phương thức này giúp tính toán và trả về khoảng thời gian mà không có đặt phòng nào,
  # nhằm xác định các ngày có thể được đặt thêm trong tương lai.
  def available_dates
    # ấy bản ghi đặt phòng sắp tới đầu tiên (gần nhất) bằng cách sử dụng phạm vi upcoming_reservations.
    next_reservation = reservations.upcoming_reservations.first
    # current_reservation: Lấy bản ghi đặt phòng hiện tại đầu tiên (nếu có) bằng cách sử dụng phạm vi current_reservations.
    current_reservation = reservations.current_reservations.first

    if current_reservation.nil? && next_reservation.nil?
      # Nếu không có đặt phòng nào cả, khoảng thời gian có sẵn sẽ từ ngày mai đến 30 ngày sau.
      Date.tomorrow.strftime("%e %b")..(Date.tomorrow + 30.days).strftime("%e %b")
    elsif current_reservation.nil?
      # Nếu không có đặt phòng đang diễn ra nhưng có một đặt phòng sắp tới, khoảng thời gian có sẵn sẽ từ ngày mai đến ngày bắt đầu của đặt phòng sắp tới.
      Date.tomorrow.strftime("%e %b")..next_reservation.checkin_date.strftime("%e %b")
    elsif next_reservation.nil?
      # Nếu có đặt phòng hiện tại nhưng không có đặt phòng sắp tới, khoảng thời gian có sẵn sẽ từ ngày trả phòng của đặt phòng hiện tại đến 30 ngày sau hôm nay.
      current_reservation.checkout_date.strftime("%e %b")..(Date.tomorrow + 30.days).strftime("%e %b")
    else
      # Nếu có cả hai loại đặt phòng, khoảng thời gian có sẵn sẽ từ ngày trả phòng của đặt phòng hiện tại đến ngày nhận phòng của đặt phòng sắp tới.
      current_reservation.checkout_date.strftime("%e %b")..next_reservation.checkin_date.strftime("%e %b")
    end
  end
end
