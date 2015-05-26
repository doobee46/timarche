namespace :relationships do
  desc "fill relationships between users"
  task follow: :environment do
  	#following relationships 
  	ProgressBar.create
  	users = User.all
  	user = users.first
  	following = users[2..10]
  	followers = users[3..9]
  	following.each {|followed| user.follow!(followed)}
  	followers.each {|follower| follower.follow!(user)}

  end

end
