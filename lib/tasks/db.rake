namespace :db do
 
  task :all => [:environment, :drop, :create, :migrate] do
  end
 
end