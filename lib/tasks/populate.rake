namespace :db do
    desc " Fill database with sample data"
    task populate: :environment do

      Category.create([
               {name: 'Electronique'},
               {name: 'Artisanat'},
               {name:'fashion'},
               {name: 'Jouets'},
               {name: 'Deals'}
               ])

     Plan.create({
          name: 'Free',
          price: 0.00,
          interval: 'month',
          stripe_id: '1',
          features: ['10 annonce', '1 Utilisateur', 'Support par email'].join("\n\n"),
          display_order: 1
        })

        Plan.create({
          name: 'Store',
          highlight: true, # This highlights the plan on the pricing page.
          price: 5.00,
          interval: 'month',
          stripe_id: '2',
          features: ['50 annonces', '3 Utilisateurs', '24/7 phone support'].join("\n\n"),
          display_order: 2
        })

        Plan.create({
          name: 'Enterprise',
          price: 10.50, 
          interval: 'month',
          stripe_id: '3', 
          features: ['Annonces illimitees', 'Utilisateurs illimites','24/7 phone and email support' ].join("\n\n"), 
          display_order: 3
        })
       
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
          price= Faker::Number.number(4)
          image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages','*')).sample)
       	  description = Faker::Lorem.sentence
       	  user.listings.create!(name: name, description: description, price: price)
        end    
     end 
   end
  end
end