class CreateCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :personality
      t.string :race
      t.string :role
      t.string :gender
      t.string :history
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
