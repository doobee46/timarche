class ListingsController < ApplicationController
   
  before_filter :set_search
  before_filter :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js

  def dashboard
    @listing = Listing.new
    @categories = Category.all
    @listings = Listing.where(user: current_user).paginate(:page => params[:page], :per_page => 50).order('created_at DESC')
    params[:page] ||=1
    @activities =Activity.for_user(current_user, params)
    render layout: "dashboard"
  end

  def index
    @q = Listing.includes(:user, :impressions, :like, :category).search(params[:q]) 
    @listings= @q.result.paginate(:page => params[:page], :per_page => 40).order('created_at DESC')
    @featured = @listings.limit(5)
    @trend = Listing.where("impressions_count >=10").limit(5).order('created_at DESC')
    @categories = Category.all
    @users=User.all
    @notifications= Notification.all
    respond_with(@listings)
  end
    
  def show
    @categories = Category.all
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
      @categories= Category.all
  end

  def create
    @users = User.all
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    if @listing.save
      if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @listing.pictures.create(image: image)
          }
       end
     #current_user.create_activity(@listing, "published")
     (@users - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "posted", notifiable: @listing)
     end 
     flash[:notice]= "L'annonce #{@listing.listing_number} a eté publiee avec succès."
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

   
  def recent
    @categories = Category.all  
    @recent = Listing.recent.page(params[:page]).per_page(30).order("created_at DESC")
    respond_with(@recent)
  end

  def popular
    @categories = Category.all  
    @popular = Listing.popular.page(params[:page]).per_page(30).order("created_at DESC")
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
      params.require(:listing).permit(:name, :description, :price, :image, :category_id, :listing_number, :user_id, :display_usd)
    end


end