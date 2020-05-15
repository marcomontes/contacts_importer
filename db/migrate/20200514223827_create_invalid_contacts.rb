class CreateInvalidContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :invalid_contacts do |t|
      t.references :csv_file, foreign_key: true
      t.string :name
      t.string :birthdate_str
      t.string :phone
      t.string :address
      t.string :cc_franchise
      t.string :cc_number
      t.integer :cc_last_four
      t.string :email
      t.text   :error_msgs, array: true, default: []
      t.timestamps
    end
  end
end
