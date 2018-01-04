namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Electromenagers'},
               {name: 'Vehicules'},
               {name: 'Immobiliers'},
               {name: 'Maisons'},
               {name: 'Ordinateurs'},
               {name: 'Bijoux'},
               {name: 'Electroniques'},
               {name: 'Antiquités'},
               {name: 'Cellphones'},
               {name: 'Outils'},
               {name: 'Sports'},
               {name: 'Autres'},
               ])
    end
   
end
