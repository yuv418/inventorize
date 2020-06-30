class ChangeAutofillToBoolFromSchema < ActiveRecord::Migration[6.0]
  def change
    change_column :schemas, :autofill, :bool
  end
end
