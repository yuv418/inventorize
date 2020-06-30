class AddAutofillMappingToSchemas < ActiveRecord::Migration[6.0]
  def change
    add_column :schemas, :autofill_mapping, :json
  end
end
