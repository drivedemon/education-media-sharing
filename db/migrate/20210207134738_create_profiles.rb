class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, limit: 50
      t.string :last_name, limit: 100
      t.string :username, limit: 20
      t.datetime :date_of_birth
      t.integer :gender
      t.string :phone_number
      t.string :street_line1
      t.string :street_line2
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :postcode
      t.string :professional
      t.string :educational
      t.string :work_place
      t.string :national_id

      t.timestamps
    end
  end
end
