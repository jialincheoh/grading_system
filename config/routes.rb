Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :graders

  devise_scope :grader do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end

  resources :graders
  resources :projects do
    get 'download', on: :collection
    resources :grades do
      get 'show_novelty_fields' => 'grades#show_novelty_fields'
      get 'edit_novelty_fields' => 'grades#edit_novelty_fields'
      patch 'update_novelty_fields' => 'grades#update_novelty_fields'
      get 'download'
    end

    get 'novelty_fields' => 'grades#new_novelty_fields'
    get 'list_novelty_fields' => 'grades#list_novelty_fields'
    post 'novelty_fields' => 'grades#create_novelty_fields'
  end

  resources :students

  root to: "projects#index"

  get 'scores' => 'scores#index'
  get 'total_scores' => 'scores#total_scores'
  get 'usability_grading_instructions' => 'grades#usability_grading_instructions'
  get 'technical_grading_instructions' => 'grades#technical_grading_instructions'
end
