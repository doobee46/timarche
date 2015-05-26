namespace :plan do
    desc " Fill database with sample data"
    task populate: :environment do

       Plan.create({
          name: 'Free',
          price: 0.00,
          interval: 'month',
          stripe_id: '1',
          features: ['10 annonces', '1 Utilisateur', 'Support par email'].join("\n\n"),
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
   end
end