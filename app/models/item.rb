class Item < ApplicationRecord
  belongs_to :schema
  has_and_belongs_to_many :categories
  serialize :data, JSON

  def field_data
    (self.schema.fields.zip self.data).to_h
  end
end
