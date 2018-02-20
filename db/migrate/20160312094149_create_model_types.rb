class CreateModelTypes < ActiveRecord::Migration
  def change
    create_table :model_types do |t|
      t.references :model, index: true
      t.string :name
      t.string :model_type_slug
      t.integer :model_type_code
      t.integer :base_price, limit: 6

      t.timestamps
    end
  end
end
