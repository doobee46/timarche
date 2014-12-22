namespace :db do
    desc " Fill database with sample data"
    task populate: :environment do
   
      puts "----------------"
      puts "--- populate ---"
      puts "----------------"

      puts "----------------"
      puts "---- users  ----"
      puts "----------------"

    	10.times do |n|
    		puts"[DEBUG] creating user #{n+1} of 10"
    		name = Faker::Name.name
        username = Faker::Internet.user_name
        avatar =  Faker::Avatar.image("avatar", "30x30", "jpg")
    		email ="user-#{n+1}@example.com"
    		password ="password"
    		User.create!( name: name,
    			          email: email,
                    username: username,
    			          password: password,
    			          password_confirmation: password,
                    )
    
       
       User.all.each do |user|
          puts "----------------"
          puts "----listings----"
          puts "----------------"
       	  puts "[DEBUG] Creating listings for user #{user.id} of #{User.last.id}"
          
       	10.times do|n|
          name = Faker::Lorem.word   	 
          price= Faker::Number.number(2)
          image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages','*')).sample)
       	  description = Faker::Lorem.sentence
       	  user.listings.create!(name: name, description: description, price: price)
        end    
     end 
   end
  end
end