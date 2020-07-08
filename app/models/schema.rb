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

  def field_autofill
    fields.each_with_index.map{ |f, i| [f, self.autofill_mapping[i]] }.to_h
  end

  def autofiller_class
    (Schema.last.autofiller.titlecase + "Autofiller").constantize
  end
end
