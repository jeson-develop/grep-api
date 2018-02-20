module API
  module V1
    class Models < Grape::API

      resource :models do
        before do
          authenticate!
        end
        # Get a single model
        #
        # Parameters:
        #   model_slug (required) - The model_slug of a model
        # Example Request:
        #   GET /models/:model_slug/model_types
        params do
          requires :model_slug
        end
        get '/:model_slug/model_types' do
          # authenticate!
          models = Model.where(model_slug: params[:model_slug])
          {models: models.collect{|m| {name: m.name, model_types: m.model_types.map{|mt| {name: mt.name, total_price: mt.total_price}}}}}
        end

        # Return model_type based on base_price
        #
        # Parameters:
        #   model_slug (required) - The model_slug of a model
        #   model_type_slug (required) - The model_type_slug of a model_type
        #   base_price (required) - The base_price of a model_type
        # Example Request:
        #   POST /models/:model_slug/model_types_price/:model_type_slug
        params do
          requires :model_slug
          requires :model_type_slug
          requires :base_price
        end
        post '/:model_slug/model_types_price/:model_type_slug' do
          model_type = ModelType.joins(:model).where(models: {model_slug: params[:model_slug]}, model_type_slug: params[:model_type_slug]).first
          model_type.base_price = params[:base_price].to_i
          {model_type: {name: model_type.name, base_price: model_type.base_price, total_price: model_type.total_price}}
        end
      end
    end
  end
end
