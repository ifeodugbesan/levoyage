class CreateGuesses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesses do |t|
      t.string :words, array: true
      t.references :attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
