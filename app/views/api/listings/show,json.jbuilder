json.listing do  
  json.id    @listing.id
  json.title @listing.name
  json.description @listing.description
  json.image @listing.image
  json.pictures @listing.pictures
  
  json.user_id @listing.user ? @listing.user.id : nil
end  