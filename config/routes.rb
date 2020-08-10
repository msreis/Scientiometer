# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sub_activity_types
  resources :postdoc_books
  resources :student_books
  resources :researcher_books
  resources :books
  resources :postdoc_papers
  resources :submissions
  resources :coordination_degrees
  resources :capes_concepts
  resources :postdocs
  resources :multiuser_subjects
  resources :multiuser_activities
  resources :multiuser_articles
  resources :multiuser_theses
  resources :intern_multiusers
  resources :multiuser_grants
  resources :responsible_multiusers
  resources :researcher_multisers
  resources :multiuser_in_labs
  resources :multiusers
  resources :theses
  resources :supervision_types
  resources :course_coordinations
  resources :course_classifications
  resources :ministered_classes
  resources :accreditations
  resources :subjects
  resources :lectures
  resources :postgraduate_programs
  resources :institutions
  resources :course_degrees
  resources :scholarships
  resources :grant_extensions
  resources :grants
  resources :grant_participation_types
  resources :grant_project_types
  resources :funding_agencies
  resources :activities
  resources :activity_types
  resources :congress_participations
  resources :congresses
  resources :congress_roles
  resources :student_papers
  resources :researcher_papers
  resources :articles
  resources :collaboration_types
  resources :qualis
  resources :scientometric_indices
  resources :line_of_researches
  resources :productivity_grants
  resources :fb_levels
  resources :cnpq_levels
  resources :advisements
  resources :advisement_degrees
  resources :interns
  resources :notes
  resources :researchers
  resources :post_doc_types
  resources :employees
  resources :titles
  resources :role_foundation_levels
  resources :laboratories
  resources :laboratory_divisions
  resources :profiles
  resources :accounts, only: [:index, :update]
  resources :accounts, param: :username, only: [:show]
  post '/auth/login', to: 'authentication#login'
  get '/doi', to: 'doi#resolve'
  post '/forms/steps', to: 'forms#step'
  get '/forms/steps/:step', to: 'steps_data#get_step'
  get '/sub_by_lab/:laboratory', to: 'submissions#submissions'
  get '/me/submissions', to: 'submissions#my_submissions'
  get '/submissions_summary', to: 'submissions#summary'
  get '/mscs', to: 'interns#mscs'
  get '/phds', to: 'interns#phds'
  get '/ics', to: 'interns#ics'
  get '/adv_by_res', to: 'advisements#advisements_by_researcher'
  post '/accept/:id', to: 'submissions#accept'
  post '/reprove/:id', to: 'submissions#reprove'
  post '/submit/:id', to: 'submissions#submit'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
