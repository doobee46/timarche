class ListingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def seller
    @listings = Listing.where(user: current_user).paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  def index
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @featured = @listings.limit(5)
    @users=User.all
    respond_with(@listings)
  end


  def show
    commontator_thread_show(@listing)
    impressionist(@listing) 
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
    if @listing.save
      if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @listing.pictures.create(image: image)
          }
       end
    flash[:notice]= 'Listing <%=listing.id %> was successfully published.'
    respond_with(@listing)
     end
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
      @listing = Listing.friendly.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :category_id, :listing_number)
    end


end