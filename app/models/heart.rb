class Heart < ActiveRecord::Base
   belongs_to :listing
   belongs_to :user
  
   validates :user_id, uniqueness: { scope: :listing_id }
    
   def self.favorites(user)
       favs = []
       listings = Listing.all
       hearts = user.hearts.collect
       listings.each do |listing|
         hearts.each do |heart|
           if heart.listing_id == listing.id
             favs.push << listing
           end
         end
       end
     return favs
   end
  
  
  
end
