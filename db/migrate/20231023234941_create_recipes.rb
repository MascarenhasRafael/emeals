class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image_path
      t.integer :cook_time_in_seconds
      t.integer :prep_time_in_seconds

      t.timestamps
    end
  end
end
