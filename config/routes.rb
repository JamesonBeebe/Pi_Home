Rails.application.routes.draw do
  resources :devices do
    get 'pin_high', to: 'devices#pin_high'
    get 'pin_low', to: 'devices#pin_low'
    get 'serial_out', to: 'devices#serial_out'
  end


  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
