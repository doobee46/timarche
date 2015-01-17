class SellersController < ApplicationController
  def index
  	@sellers  = User.all.paginate(:page => params[:page], :per_page => 30)
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  	@user = User.find_by_username(params[:id])
  	@listings = @user.listings.paginate(:page => params[:page], :per_page => 30)
  end
end
