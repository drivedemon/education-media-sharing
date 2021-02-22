class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :media_types do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    create_table :media_sub_types do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    create_table :contents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :amount
      t.references :category, null: false, foreign_key: true
      t.references :media_type, null: false, foreign_key: true
      t.references :media_sub_type, null: false, foreign_key: true
      t.integer :level
      t.integer :resource
      t.integer :status

      t.timestamps
    end
  end
end
