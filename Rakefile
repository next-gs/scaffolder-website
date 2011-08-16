require 'nanoc3/tasks'

desc "Start nanoc watcher and viewer"
multitask :dev => [:watch,:view]

task :watch do
  `nanoc watch`
end

task :view do
  `nanoc view`
end

namespace :template do

  desc "Add git remote branch for template website"
  task :remote do
    `git remote add template git://github.com/michaelbarton/nanoc-template.git`
  end

  desc "Fetch template branches"
  task :fetch do
    `git fetch template`
  end

  desc "Merge template master branch"
  task :merge do
    `git merge --no-ff template/master`
  end

end
