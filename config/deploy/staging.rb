set :user, CAP_PROFILE['staging']['user']
set :deploy_to, CAP_PROFILE['staging']['path']
set :port, CAP_PROFILE['staging']['port']
set :rvm_bin_path, CAP_PROFILE['staging']['rvm_bin_path']
set :rvm_ruby_string, CAP_PROFILE['staging']['rvm_ruby_path']
set :branch, CAP_PROFILE['staging']['branch']
set :domain, CAP_PROFILE['staging']['server']
set :deploy_env, "staging"
set :rails_env, "staging"
server domain, :app, :web, :primary => true
role :db, domain, :primary => true