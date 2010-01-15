# -*- coding: undecided -*-
require 'rake/clean'

task :default => :spec

desc 'Run specs'
task :spec do
  sh "./bin/spec -fs -c spec"
end

task :environment do
  $:.unshift 'lib'
  require "#{File.dirname(__FILE__)}/vendor/gems/environment"
  require 'dcmgr'
  Dcmgr.configure 'dcmgr.conf'
end

task :shell do
  sh "ruby lib/dcmgr/shell.rb dcmgr.conf"
end

task :run do
  sh "./bin/shotgun -p 3000 config.ru"
end

def input(disp, empty=false)
  print disp
  while buf = STDIN.gets
    break if buf and (buf.length > 0 or empty)
  end
  
  buf.chomp
end

desc 'Create super user'
task :createsuperuser => [ :environment ] do
  user = input("Username: ")
  exit unless user
  system "stty -echo"
  begin
    passwd = input("Password: ")
    puts
    passwd_again = input("Password (again): ", true)
    puts
  end while passwd != passwd_again
  system "stty echo"
  
  Dcmgr::Schema.createsuperuser(user, passwd)
end

namespace :db do
  desc 'Create all database tables'
  task :init => [ :environment ] do
    Dcmgr::Schema.create!
  end

  desc 'Drop all database tables'
  task :drop => [ :environment ] do
    Dcmgr::Schema.drop!
  end

  desc 'Create sample data'
  task :sample_data => [ :environment ] do
    Dcmgr::Schema.load_data 'fixtures/sample_data'
  end

  task :reset => [ :drop, :init ]
end
