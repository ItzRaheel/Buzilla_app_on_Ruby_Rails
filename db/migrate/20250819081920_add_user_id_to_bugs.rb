class AddUserIdToBugs < ActiveRecord::Migration[8.0]
  def change
    add_column :bugs, :user_id, :integer
        add_index :bugs, :user_id

  end
end
