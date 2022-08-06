# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "coin-dig"
set :repo_url, "git@github.com:brtr/coin-dig.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/app/coin-dig"

set :linked_files, fetch(:linked_files, []).push('config/application.yml').push('config/sidekiq.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# for sidekiq
set :init_system, :systemd
set :bundler_path, "/home/deploy/.rbenv/shims/bundle"
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_roles, :worker
set :sidekiq_default_hooks, false

set :pty, false
set :rails_env, fetch(:staging)
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '3.0.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :bundler_path, "/home/deploy/.rbenv/shims/bundle"
# for assets
set :assets_role, :web
set :keep_assets, 2

namespace :deploy do
  before :updated, :compile_assets_locally
  before :updated, :zip_assets_locally
  before :updated, :send_assets_zip
  before :updated, :unzip_assets
  after :finishing, :cleanup

  task :compile_assets_locally do
    run_locally do
      with rails_env: fetch(:stage) do
        execute "rm -rf ./public/assets/*"
        execute "rm -rf ./public/packs/*"
        execute 'bundle exec rails assets:precompile'
      end
    end
  end

  task :zip_assets_locally do
    run_locally do
      execute 'tar -zcvf ./tmp/assets.tar.gz ./public/assets 1> /dev/null'
      execute 'tar -zcvf ./tmp/packs.tar.gz ./public/packs 1> /dev/null'
    end
  end

  task :send_assets_zip do
    on roles(:web) do |_host|
      upload!('./tmp/assets.tar.gz', "#{release_path}/public/")
      upload!('./tmp/packs.tar.gz', "#{release_path}/public/")
    end
  end

  task :unzip_assets do
    on roles(:web) do |_host|
      execute "rm -rf #{release_path}/public/packs/*"
      execute "cd #{release_path}; tar -zxvf #{release_path}/public/assets.tar.gz 1> /dev/null"
      execute "cd #{release_path}; tar -zxvf #{release_path}/public/packs.tar.gz 1> /dev/null"
    end
  end
end
