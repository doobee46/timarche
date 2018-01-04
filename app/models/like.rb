class Like < ActiveRecord::Base
  belongs_to :listing
  has_many   :users, through: :listings
end
