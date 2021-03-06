class PagesController < ApplicationController
  before_action :check_signed_in, except:[:about, :index, :contact, :privacy, :team]
    
  before_filter :set_search
  before_filter :authenticate_user!, except: [:about, :index, :contact, :privacy, :team]
  respond_to :html, :json

  def index
   @categories = Category.all   
   @listings= @q.result
   @indexes = @listings.shuffle.sample(3)
   respond_with(@listings)
  end

  def ads
    
  end

  def about
  end

  def contact
  end
    
  def team
  end

  def privacy
    
  end

  def browse
    @categories = Category.all
    @notifications =Notification.all
  	@listings= @q.result.paginate(:page => params[:page], :per_page => 29).order('created_at DESC')
    @messages_count = current_user.mailbox.inbox({:read => false}).count
    respond_with(@listings)
  end

  def recent
    @recent = Listing.recent.order("created_at desc").page(params[:page]).per_page(30)
    respond_with(@recent)
  end

  def popular
    @popular = Listing.popular.order("created_at desc").page(params[:page]).per_page(30)
    respond_with(@popular)
  end

  def set_picture
    @listing =Listing.friendly.find(params[:picture][:listing_id]) 
  end

  def set_search
    @q=Listing.search(params[:q])
  end
    
  def check_signed_in
   redirect_to listings_path if user_signed_in?
  end

end
