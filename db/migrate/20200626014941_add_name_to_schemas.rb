class AddNameToSchemas < ActiveRecord::Migration[6.0]
  def change
    add_column :schemas, :name, :string
  end
end
