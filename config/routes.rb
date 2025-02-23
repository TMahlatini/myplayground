Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  get "now", to: "pages#now"
  get "projects", to: "pages#projects"
  get "notebook", to: "notebooks#notebook"

  #Note book static
  get 'notebooks/notebook'

  #book routes
  get 'notebook/books', to: 'notebooks#books'
  get 'notebook/books/:id', to: 'notebooks#book_post', as: 'book_post'

  #conversation routes
  get 'notebook/conversations', to: 'notebooks#conversations'
  get 'notebook/conversations/:id', to: 'notebooks#conversation_post', as: 'conversation_post'

  #random routes
  get 'notebook/random', to: 'notebooks#random'
  get 'notebook/random/:id', to: 'notebooks#random_post', as: 'random_post'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
