Rails.application.routes.draw do
  root :to => "static_pages#index"

  resources :posts

  match 'tagged' => 'posts#tagged', :as => 'tagged', :via => [:get]
  match '/api/posts/publish' => 'posts#publish', :via => [:post]
  match '/api/tags' => 'tags#allthetags', :via => [:get]
  match '/api/tags/search/:name' => 'tags#tagsearch', :via => [:get]
  match '/api/tags/search/' => 'tags#allthetags', :via => [:get]
  match 'taggedbyid' => 'posts#tagged', :as => 'taggedbyid', :via => [:get]


end
