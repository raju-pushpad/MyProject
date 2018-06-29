Rails.application.routes.draw do
  
 
  get 'reader/index'
	get 'admin/verify/:id' , to: 'admin#verify', as: 'admin/verify'
  get 'author/reply/:id' , to: 'author#reply', as: 'author/reply'
  get 'author/submit_reply'
  get 'author/all_post'
  post 'reader/like_post/:id', to: 'reader#like_post', as: 'reader/like_post'
  get 'reader/dislike_post'
  get 'welcome/like_post'
 
  devise_for :users, :controllers => {
   :omniauth_callbacks => "users/omniauth_callbacks" ,
   :registrations => "users/registrations",
   omniauth_callbacks: 'users/omniauth_callbacks',
   :omniauth_callbacks => "users/omniauth_callbacks"

 }

 

  

  
  # devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :admin
  resources :editor
  resources :author
  resources :reader

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
