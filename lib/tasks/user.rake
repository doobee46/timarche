namespace :user do
    desc " Fill database with sample user data"
    task populate: :environment do
       
      puts "----------------"
      puts "--- populate ---"
      puts "----------------"

      puts "----------------"
      puts "---- users  ----"
      puts "----------------"

    	30.times do |n|
    		puts"[DEBUG] creating user #{n+1} of 100"
    		name = Faker::Name.name
            username = Faker::Internet.user_name(%w(_))
            avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleavatar','*')).sample)
    		email ="user-#{n+1}@example.com"
    		password ="password"
            location =Faker::Address.city
            bio =Faker::Lorem.paragraph
    		User.create!( name: name,
    			          email: email,
                          avatar: avatar,
                          username: username,
    			          password: password,
    			          password_confirmation: password,
                          bio: bio,
                          location:location
                         )
        end
   end
 end