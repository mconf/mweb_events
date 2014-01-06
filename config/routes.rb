Eventplug::Engine.routes.draw do
  resources :events do
    resources :participants
  end
end
