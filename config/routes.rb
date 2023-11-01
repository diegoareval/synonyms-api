Rails.application.routes.draw do
  resources :synonyms, only: [:index, :create]
  post '/admin/login', to: 'admin#login'
  put '/admin/accept-synonym/:id', to: 'synonyms#accept_synonym'
  delete '/admin/delete_synonym/:id', to: 'synonyms#delete_synonym'
  get '/admin/unapproved_synonyms', to: 'synonyms#unapproved_synonyms'
end
