class CreateObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :observations do |t|
      t.decimal :current_temperature, precision: 5, scale: 2
      t.string :description

      t.timestamps
    end
  end
end
