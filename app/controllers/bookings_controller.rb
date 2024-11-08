class BookingsController < ApplicationController
  before_action :authenticate_user!
  def new
    @property = Property.find(params[:property_id])
    # lấy thông tin từ url
    @checkin_date = Date.parse(params[:checkin_date])
    @checkout_date = Date.parse(params[:checkout_date])

    # number of nights
    @number_of_nights = numberOfNights()
    # base fare
    @base_fare = @property.price * @number_of_nights
    # service fee
    @service_fee = @base_fare * 0.18
    # total amount
    @total_amount = @base_fare + @service_fee
  end

  private
  def numberOfNights
    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])
    (checkout_date - checkin_date).to_i
  end
  # Định nghĩa các tham số hợp lệ (property_id, checkin_date, checkout_date)
  # mà controller cho phép nhận vào để đảm bảo an toàn.
  def booking_params
    params.permit(:property_id, :checkin_date, :checkout_date)
  end
end
