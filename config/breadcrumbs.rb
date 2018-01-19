crumb :root do
  link "Home", browse_path
end

crumb :categories do |category|
  link category.name, category_path(category)
end

crumb :listings do |listing|
  link listing.category.name, category_path(listing.category)
  link listing.name, listings_path(listing)
end

crumb :listings do |listing|
  link listing.category.name, category_path(listing.category)
  link listing.name, listings_path(listing)
end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).