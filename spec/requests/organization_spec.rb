require 'rails_helper'

describe 'Organizations, type: :request' do
  before do
    @organization = FactoryGirl.create(:organization)
  end

  # URL: http://lvh.me:3333/organizations/1/get_token
  describe 'POST /organizations/:organization_id/get_token' do
    it 'returns 401 unauthorised status' do
      post "/organizations/#{@organization.id + 1}/get_token"
      expect(response.response_code).to eq 401
    end
    it 'returns 201 success status' do
      post "/organizations/#{@organization.id}/get_token"
      expect(response.response_code).to eq 201
    end
  end
end
