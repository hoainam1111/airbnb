module Api
  class WishlistsController < ApplicationController
    protect_from_forgery with: :null_session
    # create   delete
    # table user_id property_id
    def create
      wishlist = Wishlist.create!(wishlist_params)
      respond_to do |format|
        format.json do
          # Trả về phản hồi ở định dạng JSON.
          # Trong trường hợp thành công,
          # phản hồi sẽ chứa đối tượng wishlist vừa tạo ở trạng thái HTTP 200 (:ok).
          render json: wishlist.to_json, status: :ok
        end
      end
    end

    def destroy
      wishlist = Wishlist.find(params[:id])
      wishlist.destroy()

      respond_to do |format|
        format.json do
          # Trả về mã trạng thái HTTP 204 (No Content),
          # nghĩa là yêu cầu đã được thực hiện thành công
          # nhưng không trả về nội dung nào.
          render json: wishlist.to_json, status: 204
        end
      end
    end

    private
    def wishlist_params
      params.permit(:user_id, :property_id)
    end
  end
end
