require 'nanoc3/tasks'

desc "Cleans, builds, and uploads website files"
task :up => [:clean, :build, :rdoc, "deploy:rsync"]

task :clean do
  out = File.join(File.dirname(__FILE__),'output')
  FileUtils.rm_rf out
  FileUtils.mkdir out
end

task :build do
  `nanoc compile`
end

task :rdoc do
  FileUtils.chdir("content/code/scaffolder") do
    `rake yard`
  end
  FileUtils.mv("content/code/scaffolder/doc","output/rdoc")
end
