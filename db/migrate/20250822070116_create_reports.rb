class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :report_name
      t.string :report_description

      t.timestamps
    end
  end
end
