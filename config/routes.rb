CGWorks::Application.routes.draw do
  
  match 'admin' => 'admin#index'
  match 'archives' => 'scrapbook#archives'
  match 'archives/:archived_month' => 'scrapbook#archived_month', :as => 'archived_month'
  match ':id' => 'scrapbook#entry', :as => 'scrapbook_entry'
  root :to => 'application#index'
  
end
