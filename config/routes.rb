Rails.application.routes.draw do
  resources :terms, only: [] do
    collection do
      get :accept
      get :reject
      get :reset
    end
  end
end
