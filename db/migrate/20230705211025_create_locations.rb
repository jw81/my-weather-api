class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :name

      t.timestamps
    end
  end
end
