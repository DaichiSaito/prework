Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hotels do
    member do
      get 'get_average_price'
    end
    collection do
      get 'crawling'
    end
  end
end
