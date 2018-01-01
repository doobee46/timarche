namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Electromenagers'},
               {name: 'Artisanat'},
               {name: 'fashion'},
               {name: 'Maisons'},
               {name: 'Pour hommes'},
               {name: 'Pour femmes'},
               {name: 'Antiquités'},
               {name: 'Enfants'},
               {name: 'Bijoux'},
               ])
    end
   
end
