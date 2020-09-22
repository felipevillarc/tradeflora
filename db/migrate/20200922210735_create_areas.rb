class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :description
      t.float :lat
      t.float :long
      t.references :user, null: false, foreign_key: true
      t.references :basin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
