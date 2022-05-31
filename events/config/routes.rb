Rails.application.routes.draw do
  # top
  root 'welcome#index'
  # login
  get "/auth/:provider/callback" => "sessions#create"
  # logout
  delete "/logout" => "sessions#destroy"
  resources :events
end
