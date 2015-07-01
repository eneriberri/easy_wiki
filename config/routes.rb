Rails.application.routes.draw do
  root :to => "static_pages#index"

  resources :posts

  match 'tagged' => 'posts#tagged', :as => 'tagged', :via => [:get]

  match '/api/tags' => 'posts#allthetags', :via => [:get]
  match '/api/tags/search/:name' => 'posts#tagsearch', :via => [:get]
  match '/api/tags/search/' => 'posts#allthetags', :via => [:get]
  match 'taggedbyid' => 'posts#tagged', :as => 'taggedbyid', :via => [:get]


end
