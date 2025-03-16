class CreateGroupConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :group_connections do |t|
      t.references :group, null: false, foreign_key: true
      t.references :connection, null: false, foreign_key: true
      t.boolean :solved, default: false

      t.timestamps
    end
  end
end
