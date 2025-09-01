class CreateBugs < ActiveRecord::Migration[8.0]
  def change
    create_table :bugs do |t|
      t.string :name
      t.text :description
      t.string :bug_status
      t.string :priority
      t.references :projects, null: false, foreign_key: true

      t.timestamps
    end
  end
end
