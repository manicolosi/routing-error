ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.resources :user_sessions
  map.resources :users, :has_many => :friendships

  map.resources :questions, :has_many => :answers
  map.resources :answers
  map.resources :votes

  map.root :questions
end
