Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'shelters#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to:'shelters#update'
  delete '/shelters/:id', to:'shelters#destroy'
  get '/shelters/:id/pets', to:'shelters#pets'

  get '/shelters/:id/pets/new', to:'pets#new'
  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/reviews', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  get '/pets', to: "pets#index"
  post '/pets', to: 'pets#create'
  get '/pets/:id', to: "pets#show"
  get '/pets/:id/edit', to: "pets#edit"
  patch 'pets/:id', to: 'pets#update'
  delete 'pets/:id', to: 'pets#destroy'
  patch 'pets/:id/pending', to: 'pets#pending'
  patch 'pets/:id/adoptable', to: 'pets#adoptable'
  get 'pets/:pet_id/applicatons', to: 'petapplications#index'

  patch '/favorites/:id', to: 'favorite#update'
  get '/favorites', to: 'favorite#index'
  delete '/favorites/:id', to: 'favorite#destroy'
  delete '/favorites', to: 'favorite#clear'

  get '/applications/new', to: 'petapplications#new'
  get '/applications/:id', to: 'petapplications#show'
  post '/applications', to: 'petapplications#create'
  patch '/applications/:app_id/pets/:id/pending', to: 'pets#pending'


end
