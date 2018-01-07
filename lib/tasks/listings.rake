namespace :listings do
    desc " Fill database with sample data"
    task populate: :environment do 
       
        User.all.each do |user|
          puts "----------------------------------------------------------------"
          puts "---------------------listings-----------------------------------"
          puts "----------------------------------------------------------------"
       	  puts "[DEBUG] Creating listings for user #{user.id} of #{User.last.id}"
          
            4.times do|n|
              categories = [1,2,3,4,5,6,7,8]
              name = Faker::Lorem.word   	 
              price= Faker::Number.number(4)
              image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages','*')).sample)
              description = Faker::Lorem.paragraph
              user.listings.create!(name: name, 
                                    description: description,
                                    image: image,
                                    price: price,
                                    category_id: categories.sample)
             end    
         end 
     end
end