Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/upload", to: "uploads#upload"

  root to: "uploads#index"
end
