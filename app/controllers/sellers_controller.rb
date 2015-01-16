class SellersController < ApplicationController
  def index
  	@sellers  = User.all
    @listings = Listing.all
  end

  def show
  	@user = User.find_by_username(params[:id])
  end
end
