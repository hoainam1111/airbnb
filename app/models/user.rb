class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishlists, dependent: :destroy
  # hiết lập mối quan hệ thông qua bảng trung gian wishlists, với source là user, để lấy ra tất cả properties đã wishlist cuar ng dungf
  has_many :wishlisted_properties, through: :wishlistd, source: :property, dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_properties, through: :reservations, source: :property, dependent: :destroy
end
