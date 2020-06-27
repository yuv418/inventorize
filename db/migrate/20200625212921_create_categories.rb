class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.references :parent, null: true, foreign_key: { to_table: 'categories' }
      t.string :name

      t.timestamps
    end
  end
end
