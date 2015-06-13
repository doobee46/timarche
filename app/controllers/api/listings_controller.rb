module Api  
  class ListingsController < Api::BaseController

    private

    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :category_id, :listing_number)
    end

      def query_params
          # this assumes that an listing belongs to a user and has an :user_id
          # allowing us to filter by this
          params.permit(:user_id, :name)
      end

  end
end  