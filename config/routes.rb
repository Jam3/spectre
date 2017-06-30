Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/' => redirect('/projects')

  resources :projects, param: :slug, only: [:index] do
    resources :suites, param: :slug, only: [:show] do
      resources :runs, param: :sequential_id, only: [:show] do
        resources :tests, param: :id, only: [:update, :new, :create] do
          post 'rerun' do
            :rerun
          end
        end
      end
    end
  end

  resources :runs, only: [:new, :create]
  resources :tests, only: [:update, :new, :create]

  get '/baselines/:key', to: 'baselines#show', as: :baseline
end
