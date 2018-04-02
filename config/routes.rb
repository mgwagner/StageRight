Rails.application.routes.draw do
  resources :notes
  resources :scripts
  resources :users
  get 'plays/index'
  post "plays/upload"
  post 'plays/cuesDB'
  get 'login/index'
  root to: 'login#index'
  
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
