Rails.application.routes.draw do
  namespace :api do
    resources :users
    get '/typeahead/:input', to: 'users#search'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
