class AddBugsToReports < ActiveRecord::Migration[8.0]
  def change
    add_reference :reports, :bug, null: true, foreign_key: true
  end
end
