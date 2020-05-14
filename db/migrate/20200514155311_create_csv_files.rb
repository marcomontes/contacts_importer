class CreateCsvFiles < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'

    create_table :csv_files do |t|
      t.string :aasm_state
      t.hstore :columns, default: {}, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
