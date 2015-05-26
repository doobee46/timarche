namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Electronique'},
               {name: 'Artisanat'},
               {name: 'fashion'},
               {name: 'Maisons'},
               {name: 'Pour homme'},
               {name: 'Pour femme'},
               {name: 'Antiquités'},
               {name: 'Enfants'},
               {name: 'Music'},
               {name: 'vendeurs vedettes'},
               ])
    end
   
end
