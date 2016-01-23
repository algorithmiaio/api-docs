require 'middleman-gh-pages'
require 'rake/clean'
require "rubygems"
require "tmpdir"
require "bundler/setup"

CLOBBER.include('build')

task :default => [:build]

GITHUB_REPONAME = "algorithmiaio/api-docs"

desc "Generate and publish docs to gh-pages"
task :publish => [:build] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp

    pwd = Dir.pwd
    Dir.chdir tmp

    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.inspect}"
    system "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
    system "git push origin master:refs/heads/gh-pages --force"
    system "echo Site updated! 💃"

    Dir.chdir pwd
  end
end