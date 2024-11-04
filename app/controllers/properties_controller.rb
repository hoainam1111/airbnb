class PropertiesController < ApplicationController
  def show
    #  tải cả đối tượng Property và các reviews liên quan để tối ưu hiệu suất khi bạn có ý định sử dụng reviews.
    @property = Property.includes(:reviews).find(params[:id])

    @overall_rating_counts = @property.reviews.group("ROUND(final_rating)").count.transform_keys(&:to_i)

    @overall_rating_counts.default = 0
  end
end
