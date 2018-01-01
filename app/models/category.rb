class Category < ActiveRecord::Base
  has_many :listings
    
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
  
   
  
	
end
