# Load DSL and set up stages
#require "capistrano/setup"
require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/rbenv'
require "capistrano/bundler"
require 'capistrano/yarn'
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require 'capistrano/puma'
require "capistrano/sidekiq"
# require "capistrano/passenger"
install_plugin Capistrano::Puma  # Default puma tasks
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }