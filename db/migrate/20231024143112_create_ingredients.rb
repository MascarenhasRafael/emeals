class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :item
      t.float :quantity
      t.string :measurement_unit

      t.timestamps
    end
  end
end
