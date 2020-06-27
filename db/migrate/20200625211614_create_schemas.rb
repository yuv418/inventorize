class CreateSchemas < ActiveRecord::Migration[6.0]
  def change
    create_table :schemas do |t|
      t.json :fields
      t.string :autofill

      t.timestamps
    end
  end
end
