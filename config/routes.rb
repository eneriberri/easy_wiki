Rails.application.routes.draw do
  root :to => "static_pages#index"
  
  resources :posts
  
  match 'tagged' => 'posts#tagged', :as => 'tagged', :via => [:get]
end
