Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       registration: 'signup',
                     },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations',
                     }
  post 'files/show'

  post 'files/update'

  post 'files/delete'

  post 'files/create'

  post 'files/index'
end
