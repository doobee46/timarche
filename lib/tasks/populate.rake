require 'spinner.rb'
namespace :app do
  desc "Populate the application with seeds data to test"
  task :populate do |t, args|
      spinner = Spinner.new
    spinner.task("Populating user", 'user:populate')
    spinner.task("Creating listing", 'listings:populate')
    spinner.task("Creating plan", 'plan:populate')
    spinner.task("Creating relationships", 'relationships:follow')
    spinner.task("creating category", 'category:create')
    spinner.spin!
  end
end
