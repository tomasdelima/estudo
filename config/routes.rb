Store::Application.routes.draw do

  root :to => 'products#index'

  devise_for :users, controllers: {:registrations => "users/registrations", sessions: "users/sessions"}

  match '/orders'                          => 'orders#index', via: [:get, :post], as: 'all_orders'
  match '/users/:user_id/orders'           => 'orders#list',  via: [:get, :post], as: 'orders'
  match '/users/:user_id/orders/:order_id' => 'orders#show',  via: [:get, :post], as: 'order'

  match '/:order_id/change_status'   => 'orders#change_status',   via: [:get, :post], as: 'change_order_status'
  match '/:order_id/get_next_status' => 'orders#get_next_status', via: [:get, :post], as: 'get_next_order_status'

  resources :products

  resources :carts

  get 'carts/set_cart' => 'carts#set_cart'
  get 'carts/products' => 'carts#products'
  match 'carts/:cart_id/remove/:id'   => 'carts#remove_product',   via: [:get, :post], as: 'remove_product'
  match 'carts/:cart_id/add/:id'      => 'carts#add_product',      via: [:get, :post], as: 'add_product'
  match 'carts/:cart_id/subtract/:id' => 'carts#subtract_product', via: [:get, :post], as: 'subtract_product'

  match '/buy' => 'carts#buy', as: 'buy_cart', via: [:get, :post]

  match '/import'           => 'users#import',           via: [:get, :post], as: 'import'
  match '/import_cart'      => 'users#import_cart',      via: [:get, :post], as: 'import_cart'
  match '/dont_import_cart' => 'users#dont_import_cart', via: [:get, :post], as: 'dont_import_cart'

  match '/minus_quantity' => 'carts#minus_quantity', via: [:get, :post]
  match '/plus_quantity'  => 'carts#plus_quantity',  via: [:get, :post]

  match '/minus_quantity/:id' => 'carts#minus_quantity', via: [:get, :post]
  match '/plus_quantity/:id'  => 'carts#plus_quantity',  via: [:get, :post]

  match '/new_tag'            => 'tags#new',    via: [:get, :post]
  match '/tags/:tag_id'       => 'tags#show',   via: [:get], as: "tag"
  # match '/tags'               => 'tags#index',  via: [:get], as: "tags"
  match '/delete_tag/:tag_id' => 'tags#delete', via: [:post],as: "delete_tag"
end
