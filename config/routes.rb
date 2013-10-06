TicketTracking::Application.routes.draw do
  resources :comments

    devise_for :users

    root :to => 'tickets#new'

    resources :departments

    resources :tickets

    get 'tickets/:id/pwned' => 'tickets#take_ownership', :url_key => /[a-z]+-\d+/i, :as => :take_ownership

=begin
    get 'tickets' => 'tickets#index'
    get 'tickets/new' => 'tickets#new'
    get 'tickets/:url_key' => 'tickets#show', :url_key => /[a-z]+-\d+/i
    get 'tickets/:url_key/edit' => 'tickets#edit', :url_key => /[a-z]+-\d+/i
    post 'tickets/:url_key' => 'tickets#update', :url_key => /[a-z]+-\d+/i
    put 'tickets/:url_key' => 'tickets#create', :url_key => /[a-z]+-\d+/i
    delete 'tickets/:url_key' => 'tickets#delete', :url_key => /[a-z]+-\d+/i
=end

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    # root 'welcome#index'

    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'

    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    # Example resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Example resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Example resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Example resource route with more complex sub-resources:
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', on: :collection
    #     end
    #   end

    # Example resource route with concerns:
    #   concern :toggleable do
    #     post 'toggle'
    #   end
    #   resources :posts, concerns: :toggleable
    #   resources :photos, concerns: :toggleable

    # Example resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end
end
