class CreateCsvFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :csv_files do |t|
      t.string :aasm_state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
