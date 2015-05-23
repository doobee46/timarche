class ActivitiesController < ApplicationController
    
  def index
      followers_ids = current_user.followers.map(&:id)
      @activities =Activity.where("user_id in (?)",followers_ids.push(current_user.id)).order("created_at desc").all  
  end
    
end
