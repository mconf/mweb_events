Rails.application.routes.draw do

  devise_for :users

  mount Eventplug::Engine => "/eventplug"
  root :to => 'eventplug/events#index'
end
