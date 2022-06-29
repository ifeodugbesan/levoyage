class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :image_url, :string
    add_column :users, :admin, :boolean, default: false
  end
end
