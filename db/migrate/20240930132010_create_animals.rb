class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.date :dateOfBirth
      t.string :species
      t.string :breed
      t.string :color
      t.float :weight
      t.references :owner, null: false, foreign_key: { to_table: :people }  # Ajoute cette ligne

      t.timestamps
    end
  end
end
