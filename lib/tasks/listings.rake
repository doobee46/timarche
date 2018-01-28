namespace :listings do
    desc " Fill database with sample data"
    task populate: :environment do 
       
        User.all.each do |user|
          puts "----------------------------------------------------------------"
          puts "---------------------listings-----------------------------------"
          puts "----------------------------------------------------------------"
       	  puts "[DEBUG] Creating listings for user #{user.id} of #{User.last.id}"
          
            3.times do|n|
              categories = [1,2,3,4,5,6,7,8,9,10,11,12,13]
              display =[true, false]
              name = Faker::Commerce.product_name   	 
              price= Faker::Commerce.price
              image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages','*')).sample)
              description = Faker::Lorem.paragraph
              user.listings.create!(name: name, 
                                    description: description,
                                    image: image,
                                    price: price,
                                    category_id: categories.sample,
                                    display_usd: display.sample)
             end    
         end 
     end
end