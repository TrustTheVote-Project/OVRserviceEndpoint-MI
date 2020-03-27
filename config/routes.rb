Rails.application.routes.draw do
  root to: 'home#index'
  resources :response_rules
  resources :response_templates
  match "*_", to: 'customized_response#get', via: [:get, :post]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
