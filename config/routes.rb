Cmsgem::Engine.routes.draw do

  # ActiveAdmin.routes(self)
  # devise_for :admin_users, ActiveAdmin::Devise.config
 
  match '*path' => 'cmsgem#route'
  root :to => "cmsgem#route"
 
end
