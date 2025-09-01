class AddAssignIdToBugs < ActiveRecord::Migration[8.0]
  def change
    add_column :bugs, :assign_id, :integer
  end
end
