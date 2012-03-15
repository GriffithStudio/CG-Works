CGWorks::Application.routes.draw do
  
  root :to => 'application#index'
  
  match 'archives' => 'scrapbook#archives'
  match 'archives/:archived_month' => 'scrapbook#archived_month', :as => 'archived_month'
  
end
