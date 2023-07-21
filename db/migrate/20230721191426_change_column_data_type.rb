class ChangeColumnDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :locations, :latitude, :string
    change_column :locations, :longitude, :string
  end
end
