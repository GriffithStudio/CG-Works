class AdminController < ApplicationController
  
  http_basic_authenticate_with(:name => APP_CONFIG['admin_username'], :password => APP_CONFIG['admin_password'], :realm => APP_CONFIG['admin_realm']) if !Rails.env.development?
  
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC')
  end
  
end