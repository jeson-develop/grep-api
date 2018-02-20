class API::Base < Grape::API
  # include API::V1::Defaults
  # prefix 'api'
  # version 'v1', using: :path
  default_format :json
  format :json


  helpers do
    def authenticate!
      error!('Unauthorized. Invalid token.', 401) unless current_organization
    end

    def current_organization
      access_token = request.headers['Access-Token']
      Organization.find_by_access_token(access_token)
    end
  end
  mount API::V1::Organizations
  mount API::V1::Models
end
