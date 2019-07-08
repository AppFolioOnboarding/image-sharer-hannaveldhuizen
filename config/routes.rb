Rails.application.routes.draw do
  resources :images, only: %i[new create show index]
  get 'images/tags/:id', to: 'images#tags_show', as: 'tags'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'
end
