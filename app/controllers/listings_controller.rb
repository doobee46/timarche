class ListingsController < ApplicationController
  
  before_filter :set_search
  before_filter :authenticate_user!, except: [:index, :recent, :popular]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def dashboard
    @listings = Listing.where(user: current_user).paginate(:page => params[:page], :per_page => 29).order('created_at DESC')
    params[:page] ||=1
    @activities =Activity.for_user(current_user, params)
    render layout: "dashboard"
  end

  def index
    @q = Listing.includes(:user, :impressions, :like, :category).search(params[:q])
    @listings= @q.result.paginate(:page => params[:page], :per_page => 29).order('created_at DESC')
    @featured = @listings.limit(5)
    @trend = Listing.where("impressions_count >=10").limit(5).order('created_at DESC')
    @users=User.all
    respond_with(@listings)

  end


  def show
    @listings= @q.result
    commontator_thread_show(@listing)
    impressionist(@listing)
    current_user.create_activity(@listing, "viewed")
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
    flash[:notice]= "L'annonce #{@listing.listing_number} a eté publiee avec succes."
     respond_with(@listing)
    current_user.create_activity(@listing, "published")
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

   
  def recent
    @recent = Listing.recent.order("created_at desc").page(params[:page]).per_page(30)
    respond_with(@recent)
  end

  def popular
    @popular = Listing.popular.order("created_at desc").page(params[:page]).per_page(30)
    respond_with(@popular)
  end

  def today
     where("listing.created_at >= ?", (Date.today))
  end

  private
    def set_search
      @q=Listing.search(params[:q])
    end

    def set_listing
      @listing = Listing.friendly.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :category_id, :listing_number)
    end


end