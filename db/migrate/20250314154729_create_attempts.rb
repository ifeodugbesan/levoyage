class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :connection, null: false, foreign_key: true
      t.integer :mistakes_remaining, default: 4
      t.boolean :completed, default: false
      t.boolean :failed, default: false

      t.timestamps
    end
  end
end
