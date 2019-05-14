Rails.application.routes.draw do
  root 'selector#index'
  get '/score', to: 'selector#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
