crumb :root do
  link "Home", root_path
end

crumb :about do
  link "about", about_path
end

crumb :post_tag do
  link '投稿一覧', root_path
  parent :root
end

crumb :user_tag do
  link 'ユーザ一覧', search_result_path(searchdata: '', search_category_select: "user_search")
  parent :root
end

crumb :post_show do |post|
  link post.title, post_path(post.id)
  parent :post_tag
end

crumb :user_show do |user|
  link user.name, mypage_path(user.id)
  parent :user_tag
end

# crumb :projects do
#   link "Projects", projects_path
# end

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
