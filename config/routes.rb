Rails.application.routes.draw do
  root 'selector#index'
  get '/get_teams' => 'selector#get_teams'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
