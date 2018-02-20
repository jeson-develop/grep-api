module API
  module V1
    class Organizations < Grape::API

      resource :organizations do
        # Get a access-token
        #
        # Parameters:
        #   organization_id (required) - id of an organization
        # Example Request:
        #   POST /organizations/:organization_id/get_token
        params do
          requires :organization_id
        end
        post '/:organization_id/get_token' do
          organization = Organization.where(id: params[:organization_id]).first
          error!('Invalid Organization ID.', 401) if organization.nil?
          organization.refresh_access_token
          {success: true}.merge(organization.attributes.slice('access_token'))
        end
      end
    end
  end
end
