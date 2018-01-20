namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Electromenagers'},
               {name: 'Vehicules'},
               {name: 'Immobiliers'},
               {name: 'Hommes'},
               {name: 'Femmes'},
               {name: 'Meubles'},
               {name: 'Electroniques'},
               {name: 'Antiquités'},
               {name: 'Cellphones'},
               {name: 'Outils'},
               {name: 'Sports'},
               {name: 'Autres'},
               ])
    end
   
end
