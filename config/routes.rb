Rails.application.routes.draw do
  resources :synonyms, only: [:index, :create]
  post '/admin/login', to: 'admin#login'
  post '/admin/accept-synonym/:id', to: 'synonyms#accept_synonym'
  get '/admin/unapproved_synonyms', to: 'synonyms#unapproved_synonyms'
end
