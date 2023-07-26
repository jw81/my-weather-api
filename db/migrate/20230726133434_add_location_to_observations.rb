class AddLocationToObservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :observations, :location, null: false, foreign_key: true
  end
end
