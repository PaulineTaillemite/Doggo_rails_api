class CreatePeople < ActiveRecord::Migration[7.2]
  def change
    create_table :people do |t|
      t.string :lastName
      t.string :firstName
      t.string :email
      t.string :phoneNumber

      t.timestamps
    end
  end
end
