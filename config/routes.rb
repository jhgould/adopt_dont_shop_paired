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
  get '/pets', to: "pets#index"
  post '/pets', to: 'pets#create'
  get '/pets/:id', to: "pets#show"
  get '/pets/:id/edit', to: "pets#edit"
  patch 'pets/:id', to: 'pets#update'
  delete 'pets/:id', to: 'pets#destroy'
  patch 'pets/:id/pending', to: 'pets#pending'
  patch 'pets/:id/adoptable', to: 'pets#adoptable'
end
