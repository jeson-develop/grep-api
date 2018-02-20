class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :public_name
      t.string :type
      t.integer :pricing_policy
      t.string :access_token
      t.timestamps
    end
  end
end
