class AddCoordinatesToAreas < ActiveRecord::Migration[6.0]
  def change
    add_column :areas, :latitude, :float
    add_column :areas, :longitude, :float
    add_column :areas, :recovery, :boolean
  end
end
