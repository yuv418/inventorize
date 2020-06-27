class AddSchemaToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :schema, null: false, foreign_key: true
  end
end
