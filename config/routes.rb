Rails.application.routes.draw do
  resources :synonyms, only: [:index, :create]
end
