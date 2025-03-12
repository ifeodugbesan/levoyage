class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.integer :mistakes_remaining, default: 4
      t.boolean :completed, default: false
      t.boolean :daily, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
