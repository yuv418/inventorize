class Schema < ApplicationRecord
  has_many :items
  serialize :fields, JSON
  after_initialize :set_defaults

  def set_defaults
    self.fields ||= []
  end
end
