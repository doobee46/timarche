class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @listings = Listing.all
    respond_with(@listings)
    @featured = @listings.limit(5)
  end


  def show
    respond_with(@listing)
  end

  def new
    @listing = Listing.new
    respond_with(@listing)
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
    respond_with(@listing)
  end

  def update
    @listing.update(listing_params)
    respond_with(@listing)
  end

  def destroy
    @listing.destroy
    respond_with(@listing)
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end
end
