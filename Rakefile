require 'nanoc3/tasks'

desc "Start nanoc watcher and viewer"
multitask :dev => [:watch,:view]

task :watch do
  `nanoc watch`
end

task :view do
  `nanoc view`
end
