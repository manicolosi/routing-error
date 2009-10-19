ActionController::Routing::Routes.draw do |map|
  map.resources :questions, :has_many => :answers

  map.root :questions
end
