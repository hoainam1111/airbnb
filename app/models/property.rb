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



  def update_average_rating
    # this will get called whenever a new review is added or updated.
    average_rating = reviews.average(:final_rating)
    update_column(:average_final_rating, average_rating)
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
end
