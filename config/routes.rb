Rails.application.routes.draw do
  namespace :api, path: '/' do
    namespace :v1, path: '/' do

      namespace :users do
        namespace :works do
          namespace :trackers do
            post "projects/create", to: "projects#create"
          end
        end
      end
    end
  end
end
