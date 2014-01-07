Rails.application.routes.draw do

  devise_for :users

  mount MwebEvents::Engine => "/mweb_events"
  root :to => 'mweb_events/events#index'
end
