class Picture < ActiveRecord::Base
  belongs_to :listing
  
  has_attached_file :image, :styles => { :large=> "564x394#" }, :default_url => "default_:style.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  Paperclip.options[:content_type_mappings] = {nil => "image/png"}
  
end
