Rails.application.routes.draw do
  get 'api/ping', to: 'api/home#ping'
  root to: 'api/home#ping'
end
