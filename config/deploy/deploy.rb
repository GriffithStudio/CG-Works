$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require 'yaml'

CAP_PROFILE = YAML.load(File.read(File.expand_path('../profile.yml', __FILE__)))

set :default_stage, "staging"
set :stages, %w(production staging)

require 'capistrano/ext/multistage'
require "rvm/capistrano"
require "bundler/capistrano"

set :application, "CGWorks"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:GriffithStudio/CG-Works.git"
default_run_options[:pty] = true

set :rvm_type, :user

ssh_options[:forward_agent] = true

namespace :deploy do
  
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Apache."
  end

  desc "Symlink extra configs and folders."
    task :symlink_extras do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
      run "ln -nfs #{shared_path}/cache #{release_path}/tmp/cache"
      run "ln -nfs #{shared_path}/cache #{release_path}/tmp/sass-cache"
    end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/cache"
    run "mkdir -p #{shared_path}/sass-cache"
    run "touch #{shared_path}/config/database.yml"
    run "touch #{shared_path}/config/app_config.yml"
    puts "Now edit the config files and fill assets folder in #{shared_path}."
  end
  
  desc "Run the bundle install command."
  task :bundle_new_release, :roles => :app do
    run "cd #{release_path} && bundle install"
  end
  
  desc "activate the post process migration."
  task :with_migration do
    puts "Migrations have been run."
  end
  
  desc "activate the post process bundle install."
  task :with_bundle do
    puts "Bundler is set to run."
  end
  
  desc "activate the post process bundle install and migration."
  task :with_bundle_and_migration do
    puts "Bundler is set to run. Migrations have been run."
  end
  
  desc "Run the precompile rake task"
  task :precompile_assets do
    run "cd #{release_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
    puts "Bundler is set to run. Migrations have been run."
  end
  
end

desc "Quick test to confirm the deployment environments and return the server information."
task :check_environment do
  run "uname -a"
end

after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:update_code", "deploy:symlink_extras"

before "deploy:with_migration", "deploy:migrations"
before "deploy:with_bundle", "deploy"
before "deploy:with_bundle_and_migration", "deploy:migrations"

after "deploy:with_migration", "deploy:cleanup"
after "deploy:with_bundle", "deploy:bundle_new_release"
after "deploy:with_bundle_and_migration", "deploy:bundle_new_release"
after "deploy:bundle_new_release", "deploy:restart"

before "deploy:restart", "deploy:precompile_assets"
