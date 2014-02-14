MwebEvents::Engine.routes.draw do
  resources :events do
    collection do
      get :select
    end
    resources :participants
  end
end
