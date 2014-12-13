class Listing < ActiveRecord::Base
  if Rails.env.development?
   has_attached_file :image, :styles => { :medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default.png"
  else
   has_attached_file :image, :styles => { :medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
