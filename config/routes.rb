resources :terms, only: [] do
  collection do
    get :accept
    get :reject
    get :reset
  end
end
