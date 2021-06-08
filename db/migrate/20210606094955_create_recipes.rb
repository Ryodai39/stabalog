class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :drink
      t.integer :popularity
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :recipes, [:user_id, :created_at]
  end
end
