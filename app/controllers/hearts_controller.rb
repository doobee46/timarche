class HeartsController < ApplicationController
  respond_to :js
 
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
end
