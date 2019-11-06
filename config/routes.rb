# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'home/register'
  get 'home/logIn'
  get 'home/projects'
  post 'home/create'
  post 'home/do_log_in'

  get 'project/all/:admin_id' => 'project#all'
  get 'project/new/:admin_id' => 'project#new'
  get 'project/update/:project_id' => 'project#update'
  get 'project/view/:project_id' => 'project#view'
  get 'project/delete/:project_id' => 'project#delete'
  post 'project/create'
  post 'project/updateProject'

  get 'design/all/:admin_url' => 'design#all'
  get 'design/view/:design_id' => 'design#view'
  get 'design/new'
  post 'design/create'

end
