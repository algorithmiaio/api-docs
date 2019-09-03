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

## Helper so we fail as soon as a command fails.
def try(command)
  system command
  if $? != 0 then
    raise "Command: `#{command}` exited with code #{$?.exitstatus}"
  end
end
