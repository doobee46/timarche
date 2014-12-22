class ListingsController < ApplicationController

  before_filter :authenticate_user!, except: [:index]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
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
    @listing.user_id = current_user.id
    @listing.save
    flash[:notice]= 'Listing was successfully published.'
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
      params.require(:listing).permit(:name, :description, :price, :image, :category_id)
    end
end
