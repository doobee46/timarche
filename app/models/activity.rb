class Activity < ActiveRecord::Base
    belongs_to :user 
	belongs_to :targetable, polymorphic: true
    
    self.per_page = 20
    
    def self.for_user(user, options={})
        options[:page] ||=1
        followers_ids = user.followers.map(&:id).push(user.id)
        where("user_id in (?)",followers_ids).
          order("created_at desc").
            page(options[:page])
    end
end
