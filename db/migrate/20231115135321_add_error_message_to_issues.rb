class AddErrorMessageToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :error_message, :text
  end
end
