class Listing < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
