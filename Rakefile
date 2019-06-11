require "rubygems"
require "tmpdir"
require "bundler/setup"

task :default => [:build]

desc "Build the static site"
task :build do
  puts "Building project"
  system "rm -rf build/*"
  try "middleman build"
  puts "Build complete 🛠"
end

desc "Serve the static site"
task :serve do
  try "bundle exec middleman server"
end

GITHUB_REPONAME = "algorithmiaio/api-docs"

desc "Generate and publish blog to gh-pages"
namespace :shippable do
  task :publish do

    Rake::Task["build"].invoke

    Dir.mktmpdir do |tmp|
      cp_r "build/.", tmp

      pwd = Dir.pwd
      Dir.chdir tmp

      try "git init"
      try "git add ."
      message = "Site updated at #{Time.now.utc}"
      if ! system "git config --get user.email" then
        config = "-c user.name='Shippable' -c user.email='devops@algorithmia.com'"
        puts "Overriding git user config"
      end
      try "git #{config} commit -m #{message.inspect}"
      try "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
      try "git push origin master:refs/heads/gh-pages --force"
      try "echo Site updated! 💃"

      Dir.chdir pwd
    end
  end
end

## Helper so we fail as soon as a command fails.
def try(command)
  system command
  if $? != 0 then
    raise "Command: `#{command}` exited with code #{$?.exitstatus}"
  end
end
