puts "\n> -- Seeding default values for Organization...\n\n"
ap showroom_org = Organization.upsert({type: 'ShowRoom', name: 'hyundai'}, public_name: 'hyundai', pricing_policy: 'flexible')

puts "\n> -- Seeding default values for Model...\n\n"
model1 = showroom_org.models.upsert({name: 'series_1'}, model_slug: 'b_series')
model2 = showroom_org.models.upsert({name: 'series_2'}, model_slug: 'b_series')
ap showroom_org.models

puts "\n> -- Seeding default values for ModelTypes...\n\n"
model1.model_types.upsert({name: 'bmw_series_1'}, model_type_slug: '330i', model_type_code: 1, base_price: 200000)
model2.model_types.upsert({name: 'bmw_series_2'}, model_type_slug: '330i', model_type_code: 1, base_price: 210000)
ap ModelType.all
