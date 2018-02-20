class Model < ActiveRecord::Base
  include Upsertable
  belongs_to :organization
  has_many :model_types
end
