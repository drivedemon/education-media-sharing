class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, limit: 50
      t.string :last_name, limit: 100
      t.string :username, limit: 20
      t.datetime :date_of_birth

      t.timestamps
    end
  end
end
