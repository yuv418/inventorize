class Item < ApplicationRecord
  belongs_to :schema
  has_and_belongs_to_many :categories
  serialize :data, JSON
  before_create :autofill
  has_one_attached :picture

  def field_data
    (self.schema.fields.zip self.data).to_h
  end

  def autofill
    if self.schema.autofill?
      feed = self.schema.autofiller_class.feed.to_s
      feed = self.schema.field_autofill.key(feed)

      autofill_data = self.schema.autofiller_class.new(field_data[feed])
      insert_hash = self.schema.fields.map{ |field| [field, nil] }.to_h

      autofill_data.field_data.each do |key, value|
        key = key.to_s
        i_key = self.schema.field_autofill.key(key)
        if i_key
          insert_hash[i_key] = value
        end
      end

      self.data = insert_hash.values

    end

  end
end
