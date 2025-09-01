class RenameProjectsIdToProjectIdInBugs < ActiveRecord::Migration[8.0]
  def change
     remove_foreign_key :bugs, column: :projects_id
    rename_column :bugs, :projects_id, :project_id
    add_foreign_key :bugs, :projects, column: :project_id
  end
end
