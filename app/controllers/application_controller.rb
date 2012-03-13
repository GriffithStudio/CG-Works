class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    render :template => '/index'
  end
  
end
