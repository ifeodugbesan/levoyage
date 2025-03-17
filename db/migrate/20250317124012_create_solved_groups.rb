class CreateSolvedGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :solved_groups do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
