class Listing < ActiveRecord::Base
  acts_as_commontable
  belongs_to :user
  belongs_to :category
  if Rails.env.development?
    has_attached_file :image, :styles => { :large=> "237x280#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64#", }, :default_url => "default.png"
  else
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
