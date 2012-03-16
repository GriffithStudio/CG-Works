CGWorks::Application.routes.draw do
  
  match 'admin' => 'admin#index'
  match 'admin/update_scrapbook_display' => 'admin#update_scrapbook_display', :as => 'admin_update_scrapbook_display', :via => :post
  match 'admin/refresh_all_tweets' => 'admin#refresh_all_tweets', :as => 'admin_refresh_all_tweets', :via => :post
  match 'admin/refresh_tweet' => 'admin#refresh_tweet', :as => 'admin_refresh_tweet', :via => :post
  match 'archives' => 'scrapbook#archives'
  match 'archives/:archived_month' => 'scrapbook#archived_month', :as => 'archived_month'
  match ':id' => 'scrapbook#entry', :as => 'scrapbook_entry'
  root :to => 'application#index'
  
end
