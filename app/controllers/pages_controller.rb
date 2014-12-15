class PagesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:about, :index]
  respond_to :html

  def index
  end

  def about
  end

  def browse
  	@listings = Listing.all
    respond_with(@listings)

  end
  
end
