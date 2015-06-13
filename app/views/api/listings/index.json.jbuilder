json.listings @listings do |listing|  
  json.id              listing.id
  json.title           listing.name
  json.description     listing.description
  json.price           listing.price
  json.image           listing.image
  json.listing_number  listing.listing_number
  json.created_at      listing.created_at
  json.pictures        listing.pictures
  
  json.listing_id listing.user ? listing.user.id : nil
end  
