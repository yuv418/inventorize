class AddAutofillerToSchema < ActiveRecord::Migration[6.0]
  def change
    add_column :schemas, :autofiller, :string
  end
end
