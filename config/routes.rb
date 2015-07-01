Rails.application.routes.draw do

  root 'main#home', as: :root
  get 'home' => 'main#home', as: :home
  get 'about' => 'main#about', as: :about
  get 'students' => 'main#students', as: :students
  get 'faculty' => 'main#faculty', as: :faculty
  get 'contact' => 'main#contact', as: :contact
  get 'terms' => 'main#terms', as: :terms
  get 'frequently-asked-questions' => 'main#faq', as: :faq
  get 'supporters' => 'main#supporters'
  get 'partners' => 'main#partners'
  get 'signup' => 'users#new', as: :signup
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:index, :new, :create, :destroy]
  resources :profile, only: [:edit, :show], controller: :users, as: :profile do
    resources :modules, only: [:index, :show], controller: :module_history, as: :module
  end
  resources :news_articles, only: [:new]
  resources :news, except: :new, param: :slug, controller: :news_articles, as: :news_articles
  resources :campuses, param: :slug
  resources :events, param: :slug
  resources :modules, param: :slug, controller: :udl_modules, as: :udl_modules
  resources :communities, param: :slug
  resources :surveys do
    resources :results, only: [:index, :show]
  end
end
