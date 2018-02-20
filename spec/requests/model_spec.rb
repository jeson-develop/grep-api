require 'rails_helper'

describe 'Models, type: :request' do
  def headers
    {'HTTP_ACCESS_TOKEN' => @organization.access_token}
  end

  before do
    @organization = FactoryGirl.create(:organization)
    @model = FactoryGirl.create(:model, organization_id: @organization.id)
    @model_type = FactoryGirl.create(:model_type, model_id: @model.id)
  end

  # URL: http://lvh.me:3333/models/b_series/model_types
  describe 'GET /models/:model_slug/model_types' do
    context 'should return model details' do
      it 'returns 401 unauthorised status' do
        get "/models/#{@model.model_slug}/model_types"
        expect(response.response_code).to eq 401
      end
      it 'returns 200 success status' do
        get "/models/#{@model.model_slug}/model_types", nil, headers
        expect(response.response_code).to eq 200
      end
      it 'has models key' do
        get "/models/#{@model.model_slug}/model_types", nil, headers
        json = JSON.parse(response.body)
        expect(json['models']).to_not be_nil
        expect(json['models']).to be_instance_of(Array)
      end
    end
  end

  # URL: http://lvh.me:3333/models/b_series/model_types_price/330i
  describe 'POST /models/:model_slug/model_types_price/:model_type_Slug' do
    context 'should return calculated model details' do
      it 'returns 401 unauthorised status' do
        get "/models/#{@model.model_slug}/model_types"
        expect(response.response_code).to eq 401
      end
      it 'returns 201 success status' do
        post "/models/#{@model.model_slug}/model_types_price/#{@model_type.model_type_slug}", {base_price: 210000}, headers
        expect(response.response_code).to eq 201
      end
      it 'has model_type key' do
        post "/models/#{@model.model_slug}/model_types_price/#{@model_type.model_type_slug}", {base_price: 210000}, headers
        json = JSON.parse(response.body)
        expect(json['model_type']).to_not be_nil
        expect(json['model_type']).to be_instance_of(Hash)
      end
      it 'returns base_price passed as parameter' do
        post "/models/#{@model.model_slug}/model_types_price/#{@model_type.model_type_slug}", {base_price: 210000}, headers
        json = JSON.parse(response.body)
        expect(json['model_type']['base_price']).to eq 210000
      end
    end
  end
end
