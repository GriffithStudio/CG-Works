set :user, CAP_PROFILE['production']['user']
set :deploy_to, CAP_PROFILE['production']['path']
set :port, CAP_PROFILE['production']['port']
set :rvm_bin_path, CAP_PROFILE['production']['rvm_bin_path']
set :rvm_ruby_string, CAP_PROFILE['production']['rvm_ruby_path']
set :branch, CAP_PROFILE['production']['branch']
set :domain, CAP_PROFILE['production']['server']
set :deploy_env, "production"
set :rails_env, "production"
server domain, :app, :web, :primary => true
role :db, domain, :primary => true