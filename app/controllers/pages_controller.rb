class PagesController < ApplicationController
  
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
