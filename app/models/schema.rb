class Schema < ApplicationRecord
  has_many :items
  serialize :fields, JSON
  serialize :autofill_mapping, JSON
  after_initialize :set_defaults

  def set_defaults
    self.fields ||= []
    self.autofill_mapping ||= []
    self.autofill = false if self.autofill == nil
    self.autofiller ||= ""
  end
end
