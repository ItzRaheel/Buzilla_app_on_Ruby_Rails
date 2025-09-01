class ForceRenameProjectsIdToProjectIdInBugs < ActiveRecord::Migration[8.0]
  def change
     # Remove old foreign key if it exists
    remove_foreign_key :bugs, column: :projects_id rescue nil
    # Rename the column if it exists
    if column_exists?(:bugs, :projects_id)
      rename_column :bugs, :projects_id, :project_id
    end
    # Add new foreign key
    add_foreign_key :bugs, :projects, column: :project_id 
  end
end
