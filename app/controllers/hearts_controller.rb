class HeartsController < ApplicationController
  respond_to :html, :json, :js
 
def show
 @heart = Heart.find(params[:listing_id])
end
  
def heart
  @user = current_user
  @listing = Listing.find(params[:listing_id])
  @user.heart!(@listing)
end

def unheart
  @user = current_user
  @heart = @user.hearts.find_by_listing_id(params[:listing_id])
  @listing = Listing.find(params[:listing_id])
  @heart.destroy!
end
  def favorites
    @user = current_user
    @categories = Category.all
    @favs = Heart.favorites(@user)
    @favorites =Kaminari.paginate_array(@favs).page(params[:page]).per(10)
    respond_with(@favorites)
  end
  
end